import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:swarden/app/core/extensions/firebase_response_extensions.dart';
import 'package:swarden/app/core/generated/translations.g.dart';
import 'package:swarden/app/data/services/local/biometrics_service.dart';
import 'package:swarden/app/core/enums/roles.dart';
import 'package:swarden/app/domain/repositories/pswd_repository.dart';

import '../../core/const/collections.dart';
import '../../domain/either/either.dart';
import '../../domain/firebase_response/firebase_response.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../../presentation/global/controllers/session_controller.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(
    this.sessionController,
    this.biometricsService,
    this.pswdRepository,
  );

  final SessionController sessionController;
  final BiometricsService biometricsService;
  final PswdRepository pswdRepository;

  @override
  User? get currentUser => FirebaseAuth.instance.currentUser;

  @override
  Future<Either<FirebaseResponse, UserModel>> signIn(
    String email,
    String password,
  ) async {
    try {
      final credentials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credentials.user == null) {
        return Either.left(const FirebaseResponse.noCredentials());
      }
      final doc = await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(credentials.user!.uid)
          .get();
      if (doc.data() == null) {
        return Either.left(const FirebaseResponse.noData());
      }
      final user = UserModel.fromJson(doc.data()!);
      sessionController.setUser(user);
      return Either.right(user);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      return Either.left(e.code.toFirebaseResponse());
    } catch (e) {
      return Either.left(
        FirebaseResponse.undefined(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FirebaseResponse, UserModel>> register({
    required String email,
    required String name,
    required String lastName,
    // required String address,
    // required String city,
    required String password,
  }) async {
    try {
      final credentials =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credentials.user == null) {
        return Either.left(const FirebaseResponse.noCredentials());
      }

      final userToCreate = UserModel(
        id: credentials.user!.uid,
        email: email,
        username: email.split('@').first,
        role: Roles.user,
        name: name,
        lastName: lastName,
      );

      await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(credentials.user!.uid)
          .set(
            userToCreate.toJson(),
          );
      sessionController.setUser(userToCreate);
      // final result = await signIn(email, password);

      return Either.right(userToCreate);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      return Either.left(
        e.code.toFirebaseResponse(),
      );
    } catch (e) {
      debugPrint(e.toString());
      return Either.left(
        FirebaseResponse.undefined(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      final result = await pswdRepository.saveMasterKey(null);
      if (result) {
        await FirebaseAuth.instance.signOut();
        sessionController.setUser(null);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<UserModel?> getUser(String userId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(userId)
          .get();
      if (doc.data() == null) return null;
      return UserModel.fromJson(doc.data()!);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<FirebaseResponse> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return const FirebaseResponse.success();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      return e.code.toFirebaseResponse();
    } catch (e) {
      debugPrint(e.toString());
      return FirebaseResponse.undefined(message: e.toString());
    }
  }

  //Delte user account ---------------------------------------------

  @override
  Future<FirebaseResponse> deleteUserAccount() async {
    if (currentUser == null) return const FirebaseResponse.noCredentials();
    try {
      final result = await _deleteFirestoreUser(currentUser!.uid);
      if (result) {
        await currentUser!.delete();
        return const FirebaseResponse.success();
      } else {
        return FirebaseResponse.undefined(
            message: texts.global.anErrorHasOccurred);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      return e.code.toFirebaseResponse();
    } catch (e) {
      debugPrint(e.toString());
      return FirebaseResponse.undefined(message: e.toString());
    }
  }

  Future<bool> _deleteFirestoreUser(String userId) async {
    try {
      final usersCollection =
          FirebaseFirestore.instance.collection(Collections.users);
      final docRef = usersCollection.doc(userId);
      final docRefSubc =
          usersCollection.doc(userId).collection(Collections.passwords);
      await docRefSubc.get().then(
        (snapshot) {
          for (DocumentSnapshot ds in snapshot.docs) {
            ds.reference.delete();
          }
        },
      );
      await docRef.delete();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  @override
  Future<bool> authenticateWithBiometrics() async {
    //is device supported and can be used biometrics?
    final canCheckBiometrics = await biometricsService.canCheckBiometrics();
    if (canCheckBiometrics) {
      return await biometricsService.authenticate();
    }
    //return true if no biometric system is set
    return true;
  }
}
