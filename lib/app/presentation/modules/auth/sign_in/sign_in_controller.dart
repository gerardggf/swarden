import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/either/either.dart';
import '../../../../domain/enums/firebase_results.dart';
import '../../../../domain/models/user_model.dart';
import '../../../../domain/repositories/authentication_repository.dart';
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
