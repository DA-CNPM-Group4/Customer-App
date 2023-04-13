import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';

class Utils {
  static final formatter = DateFormat('yyyy-MM-dd HH:mm');
  static final dmyhmFormatter = DateFormat('dd/MM/yyyy HH:mm');
  static final dmyFormatter = DateFormat('yyyy-MM-dd');
  static final hsFormatter = DateFormat.Hm();

  static String get currentDateTime {
    final DateTime now = DateTime.now();
    return formatter.format(now);
  }

  static String dateTimeFullTime(DateTime time) {
    return dmyhmFormatter.format(time);
  }

  static String dateTimeToDate(DateTime time) {
    return dmyFormatter.format(time);
  }

  static String dateTimeToTime(DateTime time) {
    return hsFormatter.format(time);
  }
}

class StringValidator {
  static String? nameValidator(String value) {
    if (value.isEmpty) {
      return "This field must be filled";
    }
    return RegExp(r'^[a-z A-Z,.\-]+$',
                caseSensitive: false, unicode: true, dotAll: true)
            .hasMatch(value)
        ? null
        : "Name can't contains special characters or number";
  }

  static String? emailValidator(String value) {
    if (value.isEmpty) {
      return "This field must be filled";
    } else if (!value.isEmail) {
      return "You must enter a email address";
    }
    return null;
  }

  static String? idValidator(String value) {
    if (value.isEmpty) {
      return "This field must be filled";
    }
    return value.length >= 12 ? null : "ID length can't be lower than 12";
  }

  static String? addressValidator(String value) {
    if (value.isEmpty) {
      return "This field must be filled";
    }
    return null;
  }

  static String? passwordValidator(String value) {
    if (value.isEmpty) {
      return "This field is required";
    } else if (value.length < 6) {
      return "Password length must be longer than 6 digits";
    }
    return null;
  }

  static String? otpValidator(String text) {
    if (text.isEmpty) {
      return "OTP can't be empty";
    } else if (text.length < 6) {
      return "Please fill all the numbers";
    }
    return null;
  }

  static String? phoneNumberValidator(String value) {
    if (value.isEmpty) {
      return "This field is required";
    } else if (!GetUtils.isPhoneNumber(value)) {
      return "This is a valid phone number";
    }
    return null;
  }
}
