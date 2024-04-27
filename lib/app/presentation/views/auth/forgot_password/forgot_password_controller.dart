import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nebben/app/domain/enums.dart';
import 'package:nebben/app/presentation/views/auth/forgot_password/state/forgot_password_state.dart';

import '../../../../domain/repositories/authentication_repository.dart';

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

  Future<FirebaseResult> forgotPassword() async {
    updateFetching(true);
    final result =
        await authenticationRepository.sendPasswordResetEmail(state.email);
    updateFetching(false);
    return result;
  }
}
