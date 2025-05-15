import 'package:flutter/cupertino.dart';

class LoginController extends ChangeNotifier {
  bool showErrorEmail = false;
  bool showErrorPassword = false;
  bool obscureTextPassword = true;

  String errorEmailMessage = '';
  String errorPasswordMessage = '';

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

  void checkPassword({required String password}) {
    if (password.isEmpty) {
      showErrorPassword = true;
      errorPasswordMessage = "Password cannot be empty.";
    } else {
      showErrorPassword = false;
      errorPasswordMessage = '';
    }

    notifyListeners();
  }

  void showCustomEmailError(String message) {
    showErrorEmail = true;
    errorEmailMessage = message;
    notifyListeners();
  }

  void changeObscureTextPassword() {
    obscureTextPassword = !obscureTextPassword;
    notifyListeners();
  }
}
