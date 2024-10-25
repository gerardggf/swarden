import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swarden/app/domain/repositories/pswd_repository.dart';

import '../../../../domain/either/either.dart';
import '../../../../domain/firebase_response/firebase_response.dart';
import '../../../../domain/models/user_model.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import 'state/sign_in_state.dart';

final signInControllerProvider =
    StateNotifierProvider<SignInController, SignInState>(
  (ref) => SignInController(
    SignInState(),
    ref.watch(authenticationRepositoryProvider),
    ref.watch(pswdRepositoryProvider),
  ),
);

class SignInController extends StateNotifier<SignInState> {
  SignInController(
    super.state,
    this.authenticationRepository,
    this.pswdRepository,
  );

  final AuthenticationRepository authenticationRepository;
  final PswdRepository pswdRepository;

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updateFetching(bool value) {
    state = state.copyWith(fetching: value);
  }

  Future<Either<FirebaseResponse, UserModel>> signIn() async {
    updateFetching(true);
    final result = await authenticationRepository.signIn(
      state.email,
      state.password,
    );
    final keySaved = await pswdRepository.saveMasterKey(state.password);
    if (!keySaved) {
      if (kDebugMode) {
        print(keySaved);
      }
    }
    updateFetching(false);
    return result;
  }
}
