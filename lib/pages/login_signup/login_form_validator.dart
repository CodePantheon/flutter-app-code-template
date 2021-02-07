import 'package:flutter/material.dart';

class LoginFormValidator{
  static final FormFieldValidator<String> nameValidator = (value) {
    if (value.isEmpty) {
      return 'Invalid name!';
    }
    return null;
  };

  static final FormFieldValidator<String> emailValidator = (value) {
    if (value.isEmpty || !Regex.email.hasMatch(value)) {
      return 'Invalid email!';
    }
    return null;
  };

  static final FormFieldValidator<String> mobileNumberValidator =
      (value) {
    if (value.isEmpty || !Regex.mobileNo.hasMatch(value)) {
      return 'Invalid Mobile No!';
    }
    return null;
  };

  static final FormFieldValidator<String> passwordValidator = (value) {
    if (value.isEmpty || value.length <= 7) {
      return 'Password is too short!';
    }
    return null;
  };
}

class Regex {
  // https://stackoverflow.com/a/32686261/9449426
  static final email = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  static final mobileNo = RegExp(r'^(\+\d{1,3}[- ]?)?\d{10}$');
}
