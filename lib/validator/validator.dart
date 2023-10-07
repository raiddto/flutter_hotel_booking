import 'package:regexpattern/regexpattern.dart';

class Valid {
  Valid._();
  static bool isEmail(String email) {
    return RegexValidation.hasMatch(email, RegexPattern.email);
  }

  static bool isUserNamee(String userName) {
    // return RegexValidation.hasMatch(userName, RegexPattern.username);
    return (userName.length >= 3 && userName.length <= 15);
  }

  static bool isPhoneNumber(String phone) {
    return RegexValidation.hasMatch(phone, RegexPattern.phone);
  }

  static bool isPassword(String email) {
    return RegexValidation.hasMatch(email, RegexPattern.passwordEasy);
  }

  static bool checkNull(String data) {
    return data != '' ? true : false;
  }
}
