import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state/pswd_item_state.dart';

final pswdItemControllerProvider =
    StateNotifierProvider<PwdItemController, PswdItemState>(
  (ref) => PwdItemController(
    PswdItemState(),
  ),
);

class PwdItemController extends StateNotifier<PswdItemState> {
  PwdItemController(super.state);

  void updateShowPassword(bool showPassword) {
    state = state.copyWith(showPassword: showPassword);
  }

  void updateFetching(bool fetching) {
    state = state.copyWith(fetching: fetching);
  }
}
