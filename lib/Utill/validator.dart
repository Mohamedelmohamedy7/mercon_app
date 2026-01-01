import 'package:easy_localization/easy_localization.dart';

class Validator {
  static String? defaultValidator(String? value) {
    if (value != null && value.trim().isEmpty) {
      return tr("error_filed_required");
    }
    return null;
  }

  static String? name(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr("error_filed_required");
      } else if (value.length < 2 ||
          value.contains(RegExp(r'[0-9]')) ||
          value.contains(RegExp(r"[$&+,:;=?@#|'<>.^*()%!]"))) {
        return tr("error_name");
      } else if (!RegExp(r"^([\u0621-\u064A]{1,})").hasMatch(value) &&
          !RegExp(r"^([a-zA-Z]{1,})").hasMatch(value)) {
        return tr("error_name");
      }
    }
    return null;
  }

  static String? price(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr("enter_price");
      }
    }
    return null;
  }

  static String? priceValidator(String? value) {
    if (value == null || value.isEmpty) {
      return tr("enter_price");
    } else if (!RegExp(r'^[0-9]+(\.[0-9]+)?$').hasMatch(value)) {
      return tr("valid_price");
    }
    final price = double.tryParse(value);
    if (price == null || price < 0) {
      return tr("positive_price");
    }
    return null;
  }

  static String? area(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr("enter_area");
      }
    }
    return null;
  }

  static String? fastOrder(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr("error_filed_required");
      }
      if (value.length < 3) {
        return tr("short_input_fast");
      }
    }
    return null;
  }

  static String? registerAddress(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr("error_filed_required");
      }
      if (value.length < 4) {
        return tr("short_address");
      }
    }
    return null;
  }

  static String? text(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr("error_filed_required");
      } else if (!RegExp('[a-zA-Z]').hasMatch(value)) {
        return tr("enter_correct_name");
      }
    }
    return null;
  }

  static String? defaultEmptyValidator(String? value) {
    return null;
  }

  static String? email(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr("error_filed_required");
      } else if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
        return tr("error_email_regex");
      }
    } else {
      return tr("error_filed_required");
    }
    return null;
  }

  static String? password(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr("error_filed_required");
      }
      if (value.length < 6) {
        return tr("error_password_validation");
      }
    }
    return null;
  }

  static String? confirmPassword(String? confirmPassword, String? password) {
    if (confirmPassword != null) {
      confirmPassword = confirmPassword.trim();
      if (confirmPassword.isEmpty) {
        return tr("error_filed_required");
      } else if (confirmPassword != password) {
        return tr("error_wrong_password_confirm");
      }
    } else {
      return tr("error_filed_required");
    }
    return null;
  }

  static String? numbers(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr("error_filed_required");
      }
      if (value.startsWith("+")) {
        value = value.replaceFirst(r'+', "");
      }
      final number = int.tryParse(value);
      if (number == null) {
        return tr("error_wrong_input");
      }
    } else {
      return tr("error_filed_required");
    }
    return null;
  }

  static String? nationalId(String? value, {bool required = true}) {
    if (value == null || value.trim().isEmpty) {
      if (required) {
        return tr("error_filed_required");
      } else {
        return null; // مش required و فاضي -> تمام
      }
    }

    value = value.trim();

    // لو فيه قيمة لازم نتحقق من صحتها
    if (!RegExp(r'^[0-9]{14}$').hasMatch(value)) {
      return tr("error_national_id");
    }

    return null; // كل شيء تمام
  }

  static String? carPlateNumber(String? value, {bool required = true}) {
    if (value == null || value.trim().isEmpty) {
      if (required) {
        return tr("error_filed_required");
      } else {
        return null; // مش required و فاضي -> تمام
      }
    }

    value = value.trim();

    // Regex لقبول الأحرف العربية/الإنجليزية + الأرقام الغربية + العربية الشرقية
    if (!RegExp(r'^([A-Za-z\u0621-\u064A]{1,4}\s?[0-9\u0660-\u0669]{1,4})$').hasMatch(value)) {
      return tr("error_car_plate");
    }

    return null; // كل شيء تمام
  }

}
