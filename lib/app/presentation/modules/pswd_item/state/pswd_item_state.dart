import 'package:freezed_annotation/freezed_annotation.dart';

part 'pswd_item_state.freezed.dart';

@freezed
class PswdItemState with _$PswdItemState {
  factory PswdItemState({
    @Default(false) bool showPassword,
    @Default(false) bool fetching,
  }) = _PswdItemState;
}
