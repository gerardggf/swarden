import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nebben/app/domain/either/either.dart';
import 'package:nebben/app/domain/enums.dart';
import 'package:nebben/app/domain/models/user_model.dart';
import 'package:nebben/app/domain/repositories/authentication_repository.dart';

import 'state/sign_in_state.dart';

final signInControllerProvider =
    StateNotifierProvider<SignInController, SignInState>(
  (ref) => SignInController(
    SignInState(),
    ref.watch(authenticationRepositoryProvider),
  ),
);

class SignInController extends StateNotifier<SignInState> {
  SignInController(super.state, this.authenticationRepository);

  final AuthenticationRepository authenticationRepository;

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updateFetching(bool value) {
    state = state.copyWith(fetching: value);
  }

  Future<Either<FirebaseResult, UserModel>> signIn() async {
    updateFetching(true);
    final result = authenticationRepository.signIn(
      state.email,
      state.password,
    );
    updateFetching(false);
    return result;
  }
}
