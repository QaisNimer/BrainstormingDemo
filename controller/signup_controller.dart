import 'package:flutter/material.dart';

class SignUpController extends ChangeNotifier {
  bool isValidName(String name) {
    return name.isNotEmpty;
  }
  bool isValidEmail(String email) {
    return email.contains('@') && email.contains('.');
  }
  bool isValidPassword(String password) {
    return password.length >= 6;
  }
  void checkName(String name) {
    notifyListeners();
  }
  void checkEmail(String email) {
    notifyListeners();
  }
  void checkPassword(String password) {
    notifyListeners();
  }
}
