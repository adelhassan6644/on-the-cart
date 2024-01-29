import '../localization/language_constant.dart';

class Validations {
  static String? name(String? value) {
    if (value!.isEmpty) {
      return getTranslated("please_enter_your_name");
    } else {
      return null;
    }
  }

  static String? mail(String? email) {
    if (email == null ||
        email.length < 8 ||
        !email.contains("@") ||
        !email.contains(".com")) {
      return getTranslated("please_enter_valid_email");
    } else {
      return null;
    }
  }

  static String? password(String? password) {
    if (password!.length < 8) {
      return getTranslated("please_enter_valid_password");
    } else {
      return null;
    }
  }

  static String? firstPassword(String? password) {
    if (password == null || password.isEmpty) {
      return getTranslated("please_enter_valid_password");
    } else if (password.length < 8) {
      return getTranslated("password_length_validation");
    } else {
      return null;
    }
  }

  static String? confirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return getTranslated("please_enter_valid_confirm_password");
    } else if (confirmPassword.length < 8) {
      return getTranslated("password_length_validation");
    } else if (password != null) {
      if (password != confirmPassword) {
        return getTranslated("confirm_password_match_validation");
      }
    }
    return null;
  }

  static String? newPassword(String? currentPassword, String? newPassword) {
    if (newPassword == null || newPassword.isEmpty) {
      return getTranslated("please_enter_valid_new_password");
    } else if (newPassword.length < 8) {
      return getTranslated("password_length_validation");
    } else if (currentPassword != null) {
      if (currentPassword == newPassword) {
        return getTranslated("new_password_match_validation");
      }
    }
    return null;
  }

  static String? confirmNewPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return getTranslated("please_enter_valid_confirm_password");
    } else if (confirmPassword.length < 8) {
      return getTranslated("password_length_validation");
    } else if (password != null) {
      if (password != confirmPassword) {
        return getTranslated("confirm_new_password_match_validation");
      }
    }
    return null;
  }

  static String? phone(String? value) {
    if (value!.isEmpty || value.length < 7) {
      return getTranslated("please_enter_valid_number");
    } else {
      return null;
    }
  }

  static String? field(String? value) {
    if (value != null || value!.isEmpty) {
      return getTranslated("required");
    } else {
      return null;
    }
  }

  static String? code(String? value) {
    if (value == null || value.length < 4) {
      return getTranslated("please_enter_valid_code");
    } else {
      return null;
    }
  }

  static String? city(String? value) {
    if (value!.toString().isEmpty) {
      return getTranslated("please_choose_city");
    } else {
      return null;
    }
  }

  static String? area(String? value) {
    if (value!.toString().isEmpty) {
      return getTranslated("please_choose_area");
    } else {
      return null;
    }
  }

  static String? feedBack(String? value) {
    if (value == null || value.length < 4) {
      return getTranslated("please_enter_your_feedback");
    } else {
      return null;
    }
  }
}
