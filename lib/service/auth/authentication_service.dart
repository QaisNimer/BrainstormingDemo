import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/const_values.dart';
import '../../model/sign_model.dart';
import '../../model/verfication_model.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import '../../model/auth_model/reset_password_model.dart';
import '../../model/auth_model/signup_model.dart';
class AuthService {
  Future<bool> login(Sign_Model input) async {
    final response = await http.post(
      Uri.parse('${ConstValue.baseUrl}api/Auth/signin'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(input.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Login successful: $data");
      return true;
    } else {
      print("Login failed: ${response.body}");
      return false;
    }
  }

  Future<bool> verifyOtp(Verfication_Model input) async {
    final response = await http.post(
      Uri.parse('${ConstValue.baseUrl}api/Auth/verify-otp'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(input.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("OTP verification successful: $data");
      return true;
    } else {
      print("OTP verification failed: ${response.body}");
      return false;
    }
  }
}


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
    setErrorMessage(null); // Clear previous error messages

    try {
      // Ensure all required fields are present
      if (!_validateRequiredFields(user)) {
        setErrorMessage('Please fill in all required fields.');
        setLoading(false);
        return false;
      }

      if (user.birthDate != null && user.birthDate!.isNotEmpty) {
        try {
          final parsedDate = DateFormat('yyyy-MM-dd').parse(user.birthDate!);
          user.birthDate = DateFormat('yyyy-MM-dd').format(parsedDate);
        } catch (e) {
          setErrorMessage('Invalid birth date format. Please use YYYY-MM-DD format.');
          setLoading(false);
          return false;
        }
      } else {
        setErrorMessage('Birth date is required.');
        setLoading(false);
        return false;
      }

      final client = createHttpClient();
      final url = Uri.parse('$baseUrl/Auth/signup');

      // Create a clean JSON without null values
      final Map<String, dynamic> userJson = {};

      if (user.email != null && user.email!.isNotEmpty) userJson['email'] = user.email!.trim();
      if (user.password != null && user.password!.isNotEmpty) userJson['password'] = user.password!.trim();
      if (user.phonenum != null && user.phonenum!.isNotEmpty) userJson['phonenum'] = user.phonenum!.trim();
      if (user.firstname != null && user.firstname!.isNotEmpty) userJson['firstname'] = user.firstname!.trim();
      if (user.lastname != null && user.lastname!.isNotEmpty) userJson['lastname'] = user.lastname!.trim();
      if (user.birthDate != null && user.birthDate!.isNotEmpty) userJson['birthDate'] = user.birthDate!.trim();

      // Print debugging information
      debugPrint('Sending sign up request to: $url');
      debugPrint('Request body: ${jsonEncode(userJson)}');

      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(userJson),
      );

      // Print server response for debugging
      debugPrint('Response status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      setLoading(false);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        try {
          // Try to parse error message from response
          final errorResponse = jsonDecode(response.body);
          final errorMsg = errorResponse['message'] ??
              errorResponse['error'] ??
              'Registration failed. Code: ${response.statusCode}';
          setErrorMessage(errorMsg);
        } catch (e) {
          // If response cannot be parsed as JSON
          setErrorMessage('Registration failed: ${response.body}');
        }
        return false;
      }
    } catch (e) {
      debugPrint('Error during sign up: $e');
      setErrorMessage('Unexpected error occurred: $e');
      setLoading(false);
      return false;
    }
  }

  // Validate required fields
  bool _validateRequiredFields(SignUpModel user) {
    // Check all required fields based on your model
    if (user.email == null || user.email!.isEmpty ||
        user.password == null || user.password!.isEmpty ||
        user.firstname == null || user.firstname!.isEmpty ||
        user.lastname == null || user.lastname!.isEmpty ||
        user.birthDate == null || user.birthDate!.isEmpty) {
      return false;
    }
    return true;
  }

  // Reset Password Function
  Future<bool> resetPassword(ResetPasswordModel resetData) async {
    setLoading(true);
    setErrorMessage(null);

    try {
      final emailParam = resetData.email.trim();
      debugPrint("Resetting password for email: $emailParam");

      final client = createHttpClient();
      final uri = Uri.parse('$baseUrl/Auth/SendOTP-To-ResetPassword').replace(
          queryParameters: {'email': emailParam}
      );

      debugPrint("Request URI: $uri");

      final response = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: '',
      );

      debugPrint("Response Status: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      setLoading(false);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        try {
          final errorResponse = jsonDecode(response.body);
          final errorMessage = errorResponse['message'] ??
              errorResponse['error'] ??
              'Password reset failed: ${response.statusCode}';
          setErrorMessage(errorMessage);
        } catch (e) {
          setErrorMessage('Password reset failed: ${response.body}');
        }
        return false;
      }
    } catch (e) {
      debugPrint("Error in resetPassword: $e");
      setErrorMessage('Unexpected error: $e');
      setLoading(false);
      return false;
    }
  }
}

