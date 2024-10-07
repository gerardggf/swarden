import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:swarden/app/core/extensions/firebase_response_extensions.dart';
import 'package:swarden/app/core/generated/translations.g.dart';
import 'package:swarden/app/data/services/local/biometrics_service.dart';
import 'package:swarden/app/domain/enums/roles.dart';

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
  );

  final SessionController sessionController;
  final BiometricsService biometricsService;

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
      return Either.left(FirebaseResponse.undefined(message: e.toString()));
    }
  }

  @override
  Future<Either<FirebaseResponse, UserModel>> register({
    required String email,
    required String name,
    required String lastName,
    required String address,
    required String city,
    required bool isCompany,
    required String password,
    String? taxName,
    String? cif,
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
        countryCode: 'ES',
      );

      await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(credentials.user!.uid)
          .set(
            userToCreate.toJson(),
          );
      sessionController.setUser(userToCreate);
      final result = await signIn(email, password);
      return result.when(
        left: (failure) {
          return Either.left(failure);
        },
        right: (data) {
          return Either.right(data);
        },
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      return Either.left(e.code.toFirebaseResponse());
    } catch (e) {
      debugPrint(e.toString());
      return Either.left(FirebaseResponse.undefined(message: e.toString()));
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      sessionController.setUser(null);
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
      DocumentReference docRef = usersCollection.doc(userId);
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
