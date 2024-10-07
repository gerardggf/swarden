import 'package:swarden/app/domain/firebase_response/firebase_response.dart';

import '../generated/translations.g.dart';

extension FirebaseResponseExtension on String {
  FirebaseResponse toFirebaseResponse() {
    final Map<String, FirebaseResponse> errors = {
      "email-already-in-use": const FirebaseResponse.emailAlreadyExists(),
      "insufficient-permission":
          const FirebaseResponse.insufficientPermission(),
      "internal-error": const FirebaseResponse.internalError(),
      "invalid-credential": const FirebaseResponse.invalidCredential(),
      "invalid-email": const FirebaseResponse.invalidEmail(),
      "invalid-id-token": const FirebaseResponse.invalidIdToken(),
      "invalid-password": const FirebaseResponse.invalidPassword(),
      "operation-not-allowed": const FirebaseResponse.operationNotAllowed(),
      "too-many-requests": const FirebaseResponse.tooManyRequests(),
      "wrong-password": const FirebaseResponse.wrongPassword(),
      "user-not-found": const FirebaseResponse.userNotFound(),
      "user-disabled": const FirebaseResponse.userDisabled(),
      "weak-password": const FirebaseResponse.weakPassword(),
      "undefined": FirebaseResponse.undefined(message: this),
      "user-already-exists": const FirebaseResponse.userAlreadyExists(),
      "requires-recent-login": const FirebaseResponse.requiresRecentLogin(),
    };
    return errors[this] ?? FirebaseResponse.undefined(message: this);
  }
}

extension FirebaseErrorsToText on FirebaseResponse {
  String toText() {
    final message =
        (this is Undefined) ? toText() : texts.auth.anErrorHasOccurred;
    final Map<FirebaseResponse, String> errorsTexts = {
      const FirebaseResponse.emailAlreadyExists():
          texts.auth.emailAlreadyExists,
      const FirebaseResponse.insufficientPermission():
          texts.auth.insufficientPermissions,
      const FirebaseResponse.internalError(): texts.auth.internalError,
      const FirebaseResponse.invalidCredential(): texts.auth.invalidCredential,
      const FirebaseResponse.invalidEmail(): texts.auth.invalidEmail,
      const FirebaseResponse.invalidIdToken(): texts.auth.anErrorHasOccurred,
      const FirebaseResponse.invalidPassword(): texts.auth.invalidPassword,
      const FirebaseResponse.operationNotAllowed():
          texts.auth.operationNotAllowed,
      const FirebaseResponse.tooManyRequests(): texts.auth.tooManyRequests,
      const FirebaseResponse.wrongPassword(): texts.auth.wrongPassword,
      const FirebaseResponse.userNotFound(): texts.auth.userNotFound,
      const FirebaseResponse.userDisabled(): texts.auth.userDisabled,
      const FirebaseResponse.weakPassword(): texts.auth.passwordIsTooWeak,
      FirebaseResponse.undefined(message: message):
          texts.auth.anErrorHasOccurred,
      const FirebaseResponse.userAlreadyExists(): texts.auth.userAlreadyExists,
      const FirebaseResponse.requiresRecentLogin():
          texts.auth.requiresRecentLogin,
    };
    return errorsTexts[this] ?? message;
  }
}
