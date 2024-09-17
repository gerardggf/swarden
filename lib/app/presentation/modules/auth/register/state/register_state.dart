import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_state.freezed.dart';

@freezed
class RegisterState with _$RegisterState {
  factory RegisterState({
    @Default('') String name,
    @Default('') String lastName,
    @Default('') String taxName,
    @Default('') String cif,
    @Default('') String address,
    @Default('') String city,
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool fetching,
    @Default(false) bool acceptsPolicy,
    @Default(false) bool acceptsMailing,
  }) = _RegisterState;
}
