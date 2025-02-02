import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swarden/app/data/services/local/biometrics_service.dart';
import 'package:swarden/app/domain/repositories/pswd_repository.dart';

import '../../data/repositories_impl/authentication_repository_impl.dart';
import '../../presentation/global/controllers/session_controller.dart';
import '../either/either.dart';
import '../firebase_response/firebase_response.dart';
import '../models/user_model.dart';

final authenticationRepositoryProvider = Provider<AuthenticationRepository>(
  (ref) => AuthenticationRepositoryImpl(
    ref.watch(sessionControllerProvider.notifier),
    ref.watch(biometricsServiceProvider),
    ref.watch(pswdRepositoryProvider),
  ),
);

abstract class AuthenticationRepository {
  Future<Either<FirebaseResponse, UserModel>> signIn(
    String email,
    String password,
  );
  Future<Either<FirebaseResponse, UserModel>> register({
    required String email,
    required String name,
    required String lastName,
    // required String username,
    // required String address,
    // required String city,
    required String password,
  });

  Future<bool> signOut();
  Future<UserModel?> getUser(String userId);
  User? get currentUser;
  Future<FirebaseResponse> sendPasswordResetEmail(String email);
  Future<FirebaseResponse> deleteUserAccount();

  Future<bool> authenticateWithBiometrics();
}
