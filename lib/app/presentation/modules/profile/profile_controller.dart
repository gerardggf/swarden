import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swarden/app/domain/firebase_response/firebase_response.dart';
import 'package:swarden/app/domain/repositories/authentication_repository.dart';

import 'state/profile_state.dart';

final profileControllerProvider =
    StateNotifierProvider<ProfileController, ProfileState>(
  (ref) => ProfileController(
    ProfileState(),
    ref.watch(authenticationRepositoryProvider),
  ),
);

class ProfileController extends StateNotifier<ProfileState> {
  ProfileController(super.state, this.authenticationRepository);

  final AuthenticationRepository authenticationRepository;

  void updateFetching(bool fetching) {
    state = state.copyWith(fetching: fetching);
  }

  Future<bool> isCorrectPassword(String password) async {
    try {
      final fUser = authenticationRepository.currentUser;
      if (fUser == null) return false;
      await fUser.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: fUser.email!,
          password: password,
        ),
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<FirebaseResponse> deleteAccount(String password) async {
    updateFetching(true);
    final result = await authenticationRepository.deleteUserAccount();
    updateFetching(false);
    return result;
  }
}
