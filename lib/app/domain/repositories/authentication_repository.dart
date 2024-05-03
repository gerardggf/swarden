import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories_impl/authentication_repository_impl.dart';
import '../../presentation/global/controllers/session_controller.dart';
import '../either/either.dart';
import '../enums/firebase_results.dart';
import '../models/user_model.dart';

final authenticationRepositoryProvider = Provider<AuthenticationRepository>(
  (ref) => AuthenticationRepositoryImpl(
    ref.watch(sessionControllerProvider.notifier),
  ),
);

abstract class AuthenticationRepository {
  Future<Either<FirebaseResult, UserModel>> signIn(
    String email,
    String password,
  );
  Future<Either<FirebaseResult, UserModel>> register({
    required String email,
    required String name,
    required String lastName,
    required String address,
    required String city,
    required bool isCompany,
    required String password,
    String? taxName,
    String? cif,
  });

  Future<bool> signOut();
  Future<UserModel?> getUser(String userId);
  User? get currentUser;
  Future<FirebaseResult> sendPasswordResetEmail(String email);
  Future<FirebaseResult> deleteUserAccount();
}
