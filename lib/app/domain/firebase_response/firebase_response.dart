import 'package:freezed_annotation/freezed_annotation.dart';

part 'firebase_response.freezed.dart';

@freezed
class FirebaseResponse with _$FirebaseResponse {
  // Casos estándar de errores
  const factory FirebaseResponse.emailAlreadyExists() = EmailAlreadyExists;
  const factory FirebaseResponse.insufficientPermission() =
      InsufficientPermission;
  const factory FirebaseResponse.internalError() = InternalError;
  const factory FirebaseResponse.invalidCredential() = InvalidCredential;
  const factory FirebaseResponse.wrongPassword() = WrongPassword;
  const factory FirebaseResponse.invalidEmail() = InvalidEmail;
  const factory FirebaseResponse.userNotFound() = UserNotFound;
  const factory FirebaseResponse.invalidIdToken() = InvalidIdToken;
  const factory FirebaseResponse.userDisabled() = UserDisabled;
  const factory FirebaseResponse.operationNotAllowed() = OperationNotAllowed;
  const factory FirebaseResponse.invalidPassword() = InvalidPassword;
  const factory FirebaseResponse.tooManyRequests() = TooManyRequests;
  const factory FirebaseResponse.weakPassword() = WeakPassword;
  const factory FirebaseResponse.userAlreadyExists() = UserAlreadyExists;
  const factory FirebaseResponse.requiresRecentLogin() = RequiresRecentLogin;
  const factory FirebaseResponse.noCredentials() = NoCredentials;
  const factory FirebaseResponse.noData() = NoData;
  const factory FirebaseResponse.wrongPin() = WrongPin;
  const factory FirebaseResponse.success({Object? data}) = Success;
  const factory FirebaseResponse.undefined({required String message}) =
      Undefined;
}
