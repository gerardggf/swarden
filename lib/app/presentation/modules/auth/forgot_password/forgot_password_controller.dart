import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swarden/app/domain/firebase_response/firebase_response.dart';

import '../../../../domain/repositories/authentication_repository.dart';
import 'state/forgot_password_state.dart';

final forgotPasswordControllerProvider =
    StateNotifierProvider<ForgotPasswordController, ForgotPasswordState>(
  (ref) => ForgotPasswordController(
    ForgotPasswordState(),
    ref.watch(authenticationRepositoryProvider),
  ),
);

class ForgotPasswordController extends StateNotifier<ForgotPasswordState> {
  ForgotPasswordController(
    super.state,
    this.authenticationRepository,
  );

  final AuthenticationRepository authenticationRepository;

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updateFetching(bool value) {
    state = state.copyWith(fetching: value);
  }

  Future<FirebaseResponse> forgotPassword() async {
    updateFetching(true);
    final result =
        await authenticationRepository.sendPasswordResetEmail(state.email);
    updateFetching(false);
    return result;
  }
}
