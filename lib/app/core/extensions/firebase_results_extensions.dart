import '../../domain/enums/firebase_results.dart';
import '../generated/translations.g.dart';

extension FirebaseErrorsExtension on String {
  FirebaseResult toFirebaseResult() {
    final Map<String, FirebaseResult> errors = {
      "email-already-in-use": FirebaseResult.emailAlreadyExists,
      "insufficient-permission": FirebaseResult.insufficientPermission,
      "internal-error": FirebaseResult.internalError,
      "invalid-credential": FirebaseResult.invalidCredential,
      "invalid-email": FirebaseResult.invalidEmail,
      "invalid-id-token": FirebaseResult.invalidIdToken,
      "invalid-password": FirebaseResult.invalidPassword,
      "operation-not-allowed": FirebaseResult.operationNotAllowed,
      "too-many-requests": FirebaseResult.tooManyRequests,
      "wrong-password": FirebaseResult.wrongPassword,
      "user-not-found": FirebaseResult.userNotFound,
      "user-disabled": FirebaseResult.userDisabled,
      "weak-password": FirebaseResult.weakPassword,
      "undefined": FirebaseResult.undefined,
      "user-already-exists": FirebaseResult.userAlreadyExists,
      "requires-recent-login": FirebaseResult.requiresRecentLogin,
    };
    return errors[this] ?? FirebaseResult.undefined;
  }
}

extension FirebaseErrorsToText on FirebaseResult {
  String toText() {
    final Map<FirebaseResult, String> errorsTexts = {
      FirebaseResult.emailAlreadyExists: texts.auth.emailAlreadyExists,
      FirebaseResult.insufficientPermission: texts.auth.insufficientPermissions,
      FirebaseResult.internalError: texts.auth.internalError,
      FirebaseResult.invalidCredential: texts.auth.invalidCredential,
      FirebaseResult.invalidEmail: texts.auth.invalidEmail,
      FirebaseResult.invalidIdToken: texts.auth.anErrorHasOccurred,
      FirebaseResult.invalidPassword: texts.auth.invalidPassword,
      FirebaseResult.operationNotAllowed: texts.auth.operationNotAllowed,
      FirebaseResult.tooManyRequests: texts.auth.tooManyRequests,
      FirebaseResult.wrongPassword: texts.auth.wrongPassword,
      FirebaseResult.userNotFound: texts.auth.userNotFound,
      FirebaseResult.userDisabled: texts.auth.userDisabled,
      FirebaseResult.weakPassword: texts.auth.passwordIsTooWeak,
      FirebaseResult.undefined: texts.auth.anErrorHasOccurred,
      FirebaseResult.userAlreadyExists: texts.auth.userAlreadyExists,
      FirebaseResult.requiresRecentLogin: texts.auth.requiresRecentLogin,
    };
    return errorsTexts[this] ?? texts.auth.anErrorHasOccurred;
  }
}
