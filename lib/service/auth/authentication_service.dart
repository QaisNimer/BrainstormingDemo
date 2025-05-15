import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';

import '../../core/const_values.dart';
import '../../model/sign_model.dart';
import '../../model/verfication_model.dart';
import '../../model/auth_model/reset_password_model.dart';
import '../../model/auth_model/forget_password_model.dart';
import '../../model/auth_model/signup_model.dart';

class AuthenticationService extends ChangeNotifier {
  final String baseUrl = '${ConstValue.baseUrl}api';
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  http.Client createHttpClient() {
    final httpClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return IOClient(httpClient);
  }

  Future<bool> login(Sign_Model input) async {
    setLoading(true);
    setErrorMessage(null);

    try {
      final client = createHttpClient();
      final response = await client.post(
        Uri.parse('$baseUrl/Auth/signin'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(input.toJson()),
      );

      setLoading(false);
      debugPrint("Login Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData.containsKey("token") && responseData["token"] is String) {
          final token = responseData["token"];
          debugPrint("Login successful. Token: $token");
          return true;
        } else {
          debugPrint("Login succeeded but no valid token found.");
          setErrorMessage("Login succeeded but no token returned.");
          return false;
        }
      } else {
        setErrorMessage('Login failed: ${response.body}');
        return false;
      }
    } catch (e) {
      setLoading(false);
      setErrorMessage("Login error: $e");
      return false;
    }
  }

  Future<bool> verifyOtp(Verfication_Model input) async {
    setLoading(true);
    setErrorMessage(null);

    try {
      final client = createHttpClient();

      final fixedPayload = jsonEncode({
        'email': input.email,
        'otpCode': input.otpCode,
        'isSignup': true,
      });

      final uri = Uri.parse('${ConstValue.baseUrl.replaceAll(RegExp(r'/+$'), '')}/api/Auth/verification');
      debugPrint("🔍 Verifying OTP to: $uri");
      debugPrint("📦 Payload: $fixedPayload");

      final response = await client.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: fixedPayload,
      );

      debugPrint("🧾 OTP Verify Response: ${response.statusCode} - ${response.body}");
      setLoading(false);

      if (response.statusCode == 200) {
        try {
          final responseData = jsonDecode(response.body);
          debugPrint("✅ OTP verified successfully: $responseData");
        } catch (_) {
          debugPrint("✅ OTP verified, but response body not in JSON format.");
        }
        return true;
      } else {
        try {
          final errorResponse = jsonDecode(response.body);
          final errorMessage = errorResponse['message'] ?? errorResponse['error'] ?? 'OTP verification failed.';
          setErrorMessage(errorMessage);
        } catch (_) {
          setErrorMessage('OTP verification failed: ${response.body}');
        }
        return false;
      }
    } catch (e) {
      setLoading(false);
      setErrorMessage("OTP verification error: $e");
      return false;
    }
  }

  Future<bool> signUp(SignUpModel user) async {
    setLoading(true);
    setErrorMessage(null);

    try {
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
      final Map<String, dynamic> userJson = {};

      if (user.email?.isNotEmpty ?? false) userJson['email'] = user.email!.trim();
      if (user.password?.isNotEmpty ?? false) userJson['password'] = user.password!.trim();
      if (user.phonenum?.isNotEmpty ?? false) userJson['phonenum'] = user.phonenum!.trim();
      if (user.firstname?.isNotEmpty ?? false) userJson['firstname'] = user.firstname!.trim();
      if (user.lastname?.isNotEmpty ?? false) userJson['lastname'] = user.lastname!.trim();
      if (user.birthDate?.isNotEmpty ?? false) userJson['birthDate'] = user.birthDate!.trim();

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

      debugPrint('Response status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      setLoading(false);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        try {
          final errorResponse = jsonDecode(response.body);
          final errorMsg = errorResponse['message'] ?? errorResponse['error'] ?? 'Registration failed.';
          setErrorMessage(errorMsg);
        } catch (_) {
          setErrorMessage('Registration failed: ${response.body}');
        }
        return false;
      }
    } catch (e) {
      setLoading(false);
      setErrorMessage('Unexpected error occurred: $e');
      return false;
    }
  }

  bool _validateRequiredFields(SignUpModel user) {
    return user.email?.isNotEmpty == true &&
        user.password?.isNotEmpty == true &&
        user.firstname?.isNotEmpty == true &&
        user.lastname?.isNotEmpty == true &&
        user.birthDate?.isNotEmpty == true;
  }

  Future<bool> resetPassword(ResetPasswordModel resetData) async {
    setLoading(true);
    setErrorMessage(null);

    try {
      final emailParam = resetData.email.trim();
      debugPrint("Resetting password for email: $emailParam");

      final client = createHttpClient();
      final uri = Uri.parse('$baseUrl/Auth/SendOTP-To-ResetPassword')
          .replace(queryParameters: {'email': emailParam});
      debugPrint("Request URI: $uri");

      final response = await client.post(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }, body: '');

      debugPrint("Response Status: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");
      setLoading(false);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        try {
          final errorResponse = jsonDecode(response.body);
          final errorMessage = errorResponse['message'] ?? errorResponse['error'] ?? 'Password reset failed.';
          setErrorMessage(errorMessage);
        } catch (_) {
          setErrorMessage('Password reset failed: ${response.body}');
        }
        return false;
      }
    } catch (e) {
      setLoading(false);
      setErrorMessage('Unexpected error: $e');
      return false;
    }
  }

  Future<bool> confirmResetPassword(ForgetPasswordModel model) async {
    setLoading(true);
    setErrorMessage(null);

    try {
      final client = createHttpClient();
      final uri = Uri.parse('$baseUrl/Auth/reset-password');

      final response = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(model.toJson()),
      );

      debugPrint("🔐 Reset Confirm Status: ${response.statusCode}");
      debugPrint("🔐 Reset Confirm Body: ${response.body}");

      setLoading(false);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        try {
          final errorResponse = jsonDecode(response.body);
          final errorMessage = errorResponse['message'] ?? errorResponse['error'] ?? 'Reset failed.';
          setErrorMessage(errorMessage);
        } catch (_) {
          setErrorMessage('Reset failed: ${response.body}');
        }
        return false;
      }
    } catch (e) {
      setLoading(false);
      setErrorMessage("Reset password error: $e");
      return false;
    }
  }
}
