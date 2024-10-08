import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_state.freezed.dart';

@freezed
class ChangePasswordState with _$ChangePasswordState {
  factory ChangePasswordState({
    @Default('') String email,
    @Default(false) bool fetching,
  }) = _ChangePasswordState;
}
