import 'package:cloud_firestore/cloud_firestore.dart';

import '../either/either.dart';

class SwardenException implements Exception {
  SwardenException([
    this.code,
    this.message,
  ]);
  String? code;
  String? message;

  factory SwardenException.firebase(FirebaseException firebaseException) {
    return SwardenException(
      firebaseException.code,
      firebaseException.message,
    );
  }
}

typedef SwardenEither<T> = Either<SwardenException, T>;
