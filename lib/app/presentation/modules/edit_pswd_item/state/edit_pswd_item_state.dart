import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_pswd_item_state.freezed.dart';

@freezed
class EditPswdItemState with _$EditPswdItemState {
  factory EditPswdItemState({
    @Default('') String name,
    @Default('') String username,
    @Default('') String password,
    @Default('') String url,
    @Default(false) bool fetching,
  }) = _EditPswdItemState;
}
