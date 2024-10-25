import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swarden/app/domain/models/pswd_item_model.dart';
import 'package:swarden/app/domain/repositories/account_repository.dart';
import 'package:swarden/app/presentation/modules/edit_pswd_item/state/edit_pswd_item_state.dart';

final editPswdItemControllerProvider =
    StateNotifierProvider<EditPswdItemController, EditPswdItemState>(
  (ref) => EditPswdItemController(
    EditPswdItemState(),
    ref.watch(accountRepositoryProvider),
  ),
);

class EditPswdItemController extends StateNotifier<EditPswdItemState> {
  EditPswdItemController(
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

  Future<bool> submit(PswdItemModel oldPswdItem) async {
    updateFetching(true);
    final result = await accountRepository.updatePswdItem(
      oldPswdItem.copyWith(
        name: state.name,
        url: state.url.isEmpty ? null : state.url,
        username: state.username,
        pswd: state.password,
      ),
    );
    updateFetching(false);
    return result;
  }
}
