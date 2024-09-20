import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:swarden/app/core/const/collections.dart';
import 'package:swarden/app/domain/either/either.dart';
import 'package:swarden/app/domain/models/pswd_item_model.dart';
import 'package:swarden/app/domain/repositories/account_repository.dart';
import 'package:swarden/app/domain/repositories/authentication_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AuthenticationRepository authRepository;

  AccountRepositoryImpl({
    required this.authRepository,
  });

  @override
  Future<Either<Exception, List<PswdItemModel>>> getPswdItems() async {
    try {
      final userId = authRepository.currentUser?.uid;
      if (userId == null) {
        return Either.left(Exception('user-is-null'));
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
      return Either.left(e);
    } catch (e) {
      return Either.left(
        Exception(
          e.toString(),
        ),
      );
    }
  }

  @override
  Stream<Either<Exception, List<PswdItemModel>>> subscribeToPswdItems() async* {
    try {
      final userId = authRepository.currentUser?.uid;
      if (userId == null) {
        yield Either.left(Exception('user-is-null'));
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
      yield Either.left(e);
    } catch (e) {
      yield Either.left(
        Exception(
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
      await ref.doc(docId).set(
            pswdItem.copyWith(id: docId).toJson(),
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
  Future<bool> updatePswdItem(PswdItemModel item) async {
    try {
      final userId = authRepository.currentUser?.uid;
      if (userId == null) {
        return false;
      }
      final ref = FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(userId)
          .collection(Collections.passwords)
          .doc(item.id);
      await ref.update(
        item.toJson(),
      );
      return true;
    } catch (e) {
      if (kDebugMode) print(e.toString());
      return false;
    }
  }
}
