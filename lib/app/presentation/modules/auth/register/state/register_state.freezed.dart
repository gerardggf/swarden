// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RegisterState {
  String get name => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get username =>
      throw _privateConstructorUsedError; // @Default('') String address,
// @Default('') String city,
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  bool get fetching => throw _privateConstructorUsedError;
  bool get acceptsPolicy => throw _privateConstructorUsedError;

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterStateCopyWith<RegisterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterStateCopyWith<$Res> {
  factory $RegisterStateCopyWith(
          RegisterState value, $Res Function(RegisterState) then) =
      _$RegisterStateCopyWithImpl<$Res, RegisterState>;
  @useResult
  $Res call(
      {String name,
      String lastName,
      String username,
      String email,
      String password,
      bool fetching,
      bool acceptsPolicy});
}

/// @nodoc
class _$RegisterStateCopyWithImpl<$Res, $Val extends RegisterState>
    implements $RegisterStateCopyWith<$Res> {
  _$RegisterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? lastName = null,
    Object? username = null,
    Object? email = null,
    Object? password = null,
    Object? fetching = null,
    Object? acceptsPolicy = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      fetching: null == fetching
          ? _value.fetching
          : fetching // ignore: cast_nullable_to_non_nullable
              as bool,
      acceptsPolicy: null == acceptsPolicy
          ? _value.acceptsPolicy
          : acceptsPolicy // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterStateImplCopyWith<$Res>
    implements $RegisterStateCopyWith<$Res> {
  factory _$$RegisterStateImplCopyWith(
          _$RegisterStateImpl value, $Res Function(_$RegisterStateImpl) then) =
      __$$RegisterStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String lastName,
      String username,
      String email,
      String password,
      bool fetching,
      bool acceptsPolicy});
}

/// @nodoc
class __$$RegisterStateImplCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res, _$RegisterStateImpl>
    implements _$$RegisterStateImplCopyWith<$Res> {
  __$$RegisterStateImplCopyWithImpl(
      _$RegisterStateImpl _value, $Res Function(_$RegisterStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? lastName = null,
    Object? username = null,
    Object? email = null,
    Object? password = null,
    Object? fetching = null,
    Object? acceptsPolicy = null,
  }) {
    return _then(_$RegisterStateImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      fetching: null == fetching
          ? _value.fetching
          : fetching // ignore: cast_nullable_to_non_nullable
              as bool,
      acceptsPolicy: null == acceptsPolicy
          ? _value.acceptsPolicy
          : acceptsPolicy // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$RegisterStateImpl implements _RegisterState {
  _$RegisterStateImpl(
      {this.name = '',
      this.lastName = '',
      this.username = '',
      this.email = '',
      this.password = '',
      this.fetching = false,
      this.acceptsPolicy = false});

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String lastName;
  @override
  @JsonKey()
  final String username;
// @Default('') String address,
// @Default('') String city,
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String password;
  @override
  @JsonKey()
  final bool fetching;
  @override
  @JsonKey()
  final bool acceptsPolicy;

  @override
  String toString() {
    return 'RegisterState(name: $name, lastName: $lastName, username: $username, email: $email, password: $password, fetching: $fetching, acceptsPolicy: $acceptsPolicy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterStateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.fetching, fetching) ||
                other.fetching == fetching) &&
            (identical(other.acceptsPolicy, acceptsPolicy) ||
                other.acceptsPolicy == acceptsPolicy));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, lastName, username, email,
      password, fetching, acceptsPolicy);

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterStateImplCopyWith<_$RegisterStateImpl> get copyWith =>
      __$$RegisterStateImplCopyWithImpl<_$RegisterStateImpl>(this, _$identity);
}

abstract class _RegisterState implements RegisterState {
  factory _RegisterState(
      {final String name,
      final String lastName,
      final String username,
      final String email,
      final String password,
      final bool fetching,
      final bool acceptsPolicy}) = _$RegisterStateImpl;

  @override
  String get name;
  @override
  String get lastName;
  @override
  String get username; // @Default('') String address,
// @Default('') String city,
  @override
  String get email;
  @override
  String get password;
  @override
  bool get fetching;
  @override
  bool get acceptsPolicy;

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterStateImplCopyWith<_$RegisterStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
