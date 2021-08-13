import 'package:flutter/material.dart';
import 'package:untitled/src/models/login_user_type.dart';

class TextFieldUtils {
  static String getAutofillHints(LoginUserType userType) {
    switch (userType) {
      case LoginUserType.Pin:
        return AutofillHints.password;
      default:
        return AutofillHints.password;
    }
  }

  static TextInputType getKeyboardType(LoginUserType userType) {
    switch (userType) {
      case LoginUserType.Pin:
        return TextInputType.visiblePassword;
      default:
        return TextInputType.visiblePassword;
    }
  }
}
