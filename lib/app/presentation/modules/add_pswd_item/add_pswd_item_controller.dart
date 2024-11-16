import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swarden/app/domain/models/pswd_item_model.dart';
import 'package:swarden/app/domain/repositories/account_repository.dart';

import 'state/add_pswd_item_state.dart';

final addPswdItemControllerProvider =
    StateNotifierProvider<AddPswdItemController, AddPswdItemState>(
  (ref) => AddPswdItemController(
    AddPswdItemState(),
    ref.watch(accountRepositoryProvider),
  ),
);

class AddPswdItemController extends StateNotifier<AddPswdItemState> {
  AddPswdItemController(
    super.state,
    this.accountRepository,
  );

  final AccountRepository accountRepository;

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateUsername(String username) {
    state = state.copyWith(username: username);
  }

  void updateUrl(String url) {
    state = state.copyWith(url: url);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updateFetching(bool value) {
    state = state.copyWith(fetching: value);
  }

  void updateHidePswd(bool value) {
    state = state.copyWith(hidePswd: value);
  }

  void updateUseBiometrics(bool value) {
    state = state.copyWith(useBiometrics: value);
  }

  Future<bool> submit() async {
    updateFetching(true);
    final result = await accountRepository.addPswdItem(
      PswdItemModel(
        name: state.name,
        url: state.url.isEmpty ? null : state.url,
        username: state.username,
        pswd: state.password,
        id: '',
        creationDate: Timestamp.now(),
        lastUpdated: Timestamp.now(),
        useBiometrics: state.useBiometrics,
      ),
    );
    updateFetching(false);
    return result;
  }
}
