import 'package:flutter/cupertino.dart';

class LoginController extends ChangeNotifier {
  bool showErrorEmail = false;
  bool showErrorPassword = false;
  bool obscureTextPassword = true;

  String errorEmailMessage = '';
  String errorPasswordMessage = '';

  // 📧 Email Validation
  void checkEmail({required String email}) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);

    if (email.isEmpty) {
      showErrorEmail = true;
      errorEmailMessage = "Email cannot be empty.";
    } else if (!regExp.hasMatch(email)) {
      showErrorEmail = true;
      errorEmailMessage = "Invalid email format.";
    } else {
      showErrorEmail = false;
      errorEmailMessage = '';
    }

    notifyListeners();
  }

  // 🔐 Password Validation
  void checkPassword({required String password, required String email}) {
    String upperCasePattern = r'[A-Z]';
    String numberPattern = r'[0-9]';
    String specialCharPattern = r'[!@#\$&*~]';

    if (password.isEmpty) {
      showErrorPassword = true;
      errorPasswordMessage = "Password cannot be empty.";
    } else if (password.length < 8) {
      showErrorPassword = true;
      errorPasswordMessage = "Password must be at least 8 characters.";
    } else if (!RegExp(upperCasePattern).hasMatch(password)) {
      showErrorPassword = true;
      errorPasswordMessage = "Password must contain at least one uppercase letter.";
    } else if (!RegExp(numberPattern).hasMatch(password)) {
      showErrorPassword = true;
      errorPasswordMessage = "Password must contain at least one number.";
    } else if (!RegExp(specialCharPattern).hasMatch(password)) {
      showErrorPassword = true;
      errorPasswordMessage = "Password must contain at least one special character (!@#\$&*~).";
    } else if (password == email) {
      showErrorPassword = true;
      errorPasswordMessage = "Password cannot be the same as email.";
    } else {
      showErrorPassword = false;
      errorPasswordMessage = '';
    }

    notifyListeners();
  }

  // Custom Error
  void showCustomEmailError(String message) {
    showErrorEmail = true;
    errorEmailMessage = message;
    notifyListeners();
  }

  // Toggle Password Visibility
  void changeObscureTextPassword() {
    obscureTextPassword = !obscureTextPassword;
    notifyListeners();
  }

  // Optional Backend Error
  void showBackendError(String message) {
    showErrorEmail = true;
    showErrorPassword = true;
    errorEmailMessage = message;
    errorPasswordMessage = message;
    notifyListeners();
  }
}
