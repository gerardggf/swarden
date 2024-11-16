import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:swarden/app/core/const/collections.dart';
import 'package:swarden/app/domain/either/either.dart';
import 'package:swarden/app/domain/models/pswd_item_model.dart';
import 'package:swarden/app/domain/models/user_model.dart';
import 'package:swarden/app/domain/repositories/account_repository.dart';
import 'package:swarden/app/domain/repositories/authentication_repository.dart';
import 'package:swarden/app/domain/repositories/pswd_repository.dart';

import '../../domain/swarden_exception/swarden_exception.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AuthenticationRepository authRepository;
  final PswdRepository pswdRepository;

  AccountRepositoryImpl({
    required this.authRepository,
    required this.pswdRepository,
  });

  @override
  Future<SwardenEither<List<PswdItemModel>>> getPswdItems() async {
    try {
      final userId = authRepository.currentUser?.uid;
      if (userId == null) {
        return Either.left(
          SwardenException('user-is-null'),
        );
      }
      final ref = FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(userId)
          .collection(Collections.passwords);
      final docs = await ref.get();
      final result = docs.docs
          .map(
            (e) => PswdItemModel.fromJson(
              e.data(),
            ),
          )
          .toList();
      return Either.right(result);
    } on FirebaseException catch (e) {
      return Either.left(
        SwardenException.firebase(e),
      );
    } catch (e) {
      return Either.left(
        SwardenException(
          e.toString(),
        ),
      );
    }
  }

  @override
  Stream<SwardenEither<List<PswdItemModel>>> subscribeToPswdItems() async* {
    try {
      final userId = authRepository.currentUser?.uid;
      if (userId == null) {
        yield Either.left(SwardenException('user-is-null'));
        return;
      }
      final ref = FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(userId)
          .collection(Collections.passwords);
      yield* ref.snapshots().map((s) => Either.right(
            s.docs
                .map(
                  (e) => PswdItemModel.fromJson(
                    e.data(),
                  ),
                )
                .toList(),
          ));
    } on FirebaseException catch (e) {
      yield Either.left(
        SwardenException.firebase(e),
      );
    } catch (e) {
      yield Either.left(
        SwardenException(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<bool> addPswdItem(PswdItemModel pswdItem) async {
    try {
      final userId = authRepository.currentUser?.uid;
      if (userId == null) {
        return false;
      }
      final ref = FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(userId)
          .collection(Collections.passwords);
      final docId = ref.doc().id;
      final encryptedPswd =
          await pswdRepository.encryptMessage(pswdItem.pswd, userId);
      await ref.doc(docId).set(
            pswdItem
                .copyWith(
                  id: docId,
                  pswd: encryptedPswd,
                )
                .toJson(),
          );
      return true;
    } catch (e) {
      if (kDebugMode) print(e.toString());
      return false;
    }
  }

  @override
  Future<bool> deletePswdItem(String itemId) async {
    try {
      final userId = authRepository.currentUser?.uid;
      if (userId == null) {
        return false;
      }
      final ref = FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(userId)
          .collection(Collections.passwords)
          .doc(itemId);
      await ref.delete();
      return true;
    } catch (e) {
      if (kDebugMode) print(e.toString());
      return false;
    }
  }

  @override
  Future<bool> updatePswdItem(PswdItemModel pswdItem) async {
    try {
      final userId = authRepository.currentUser?.uid;
      if (userId == null) {
        return false;
      }
      final ref = FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(userId)
          .collection(Collections.passwords)
          .doc(pswdItem.id);
      final encryptedPswd =
          await pswdRepository.encryptMessage(pswdItem.pswd, userId);
      await ref.update(
        pswdItem.copyWith(pswd: encryptedPswd).toJson(),
      );
      return true;
    } catch (e) {
      if (kDebugMode) print(e.toString());
      return false;
    }
  }

  //User -----------------------------------------

  @override
  Future<bool> updateUserAccountInfo(UserModel user) async {
    try {
      final userId = authRepository.currentUser?.uid;
      if (userId == null) {
        return false;
      }
      final ref =
          FirebaseFirestore.instance.collection(Collections.users).doc(userId);
      await ref.update(
        user.toJson(),
      );
      return true;
    } catch (e) {
      if (kDebugMode) print(e.toString());
      return false;
    }
  }
}
