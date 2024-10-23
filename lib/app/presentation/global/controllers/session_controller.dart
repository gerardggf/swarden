import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swarden/app/domain/repositories/pswd_repository.dart';

import '../../../domain/models/user_model.dart';

final sessionControllerProvider =
    StateNotifierProvider<SessionController, UserModel?>(
  (ref) => SessionController(
    null,
    ref.watch(pswdRepositoryProvider),
  ),
);

class SessionController extends StateNotifier<UserModel?> {
  SessionController(
    super.state,
    this.pswdRepository,
  );

  final PswdRepository pswdRepository;

  void setUser(
    UserModel? user,
  ) async {
    state = user;
  }
}
