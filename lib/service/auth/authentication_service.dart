import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import '../../core/const_values.dart';
import '../../model/auth_model/signup_model.dart';
import '../../model/auth_model/reset_password_model.dart';

class AuthenticationService extends ChangeNotifier {
  final String baseUrl = '${ConstValue.baseUrl}api';
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Set Loading State
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Set Error Message
  void setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  // HTTP Client (ignoring SSL errors)
  http.Client createHttpClient() {
    final httpClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return IOClient(httpClient);
  }

  // Sign Up Function
  Future<bool> signUp(SignUpModel user) async {
    setLoading(true);
    try {
      final client = createHttpClient();
      final response = await client.post(
        Uri.parse('$baseUrl/Auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      setLoading(false);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        final errorResponse = jsonDecode(response.body);
        setErrorMessage(errorResponse['message'] ?? 'Registration failed.');
        return false;
      }
    } catch (e) {
      setErrorMessage('Unexpected error: $e');
      setLoading(false);
      return false;
    }
  }

  // Reset Password Function
  Future<bool> resetPassword(ResetPasswordModel resetData) async {
    setLoading(true);
    try {
      final client = createHttpClient();
      final response = await client.post(
        Uri.parse('$baseUrl/Auth/SendOTP-To-ResetPassword'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(resetData.toJson()),
      );

      debugPrint("Response Status: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      setLoading(false);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        setErrorMessage('Password reset failed: ${response.body}');
        return false;
      }
    } catch (e) {
      setErrorMessage('Unexpected error: $e');
      setLoading(false);
      return false;
    }
  }
}
