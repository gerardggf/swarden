import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_pswd_item_state.freezed.dart';

@freezed
class AddPswdItemState with _$AddPswdItemState {
  factory AddPswdItemState({
    @Default('') String name,
    @Default('') String username,
    @Default('') String password,
    @Default('') String url,
    @Default(false) bool fetching,
    @Default(false) bool useBiometrics,
    @Default(false) bool hidePswd,
  }) = _AddPswdItemState;
}
