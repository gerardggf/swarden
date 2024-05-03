import '../../../core/generated/translations.g.dart';

class Validators {
  Validators._();

  static String? validateIsNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return texts.auth.theFieldCannotBeEmpty;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return texts.auth.theFieldCannotBeEmpty;
    }
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(value)) {
      return texts.auth.invalidEmail;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return texts.auth.theFieldCannotBeEmpty;
    }

    //Min 6 characters, 1 lowercase and 1 uppercase
    //TODO: apply real pswd regex
    //RegExp regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z]).{6,}$');
    // if (!regex.hasMatch(value)) {
    //   return texts.auth.passwordIsTooWeak;
    // }
    if (value.length < 6) {
      return texts.auth.passwordIsTooWeak;
    }
    return null;
  }

  static String? validateRepeatPassword(String? value, String? pswd) {
    if (value == null || value.isEmpty) {
      return texts.auth.theFieldCannotBeEmpty;
    }
    if (value != pswd) {
      return texts.auth.passwordsDoNotMatch;
    }
    return null;
  }
}
