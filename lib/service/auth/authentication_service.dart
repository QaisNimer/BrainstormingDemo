import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import '../../core/const_values.dart';
import '../../model/auth_model/reset_password_model.dart';
import '../../model/sign_model.dart';
import '../../model/verfication_model.dart';

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

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  http.Client createHttpClient() {
    final httpClient =
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    return IOClient(httpClient);
  }

  // Future<bool> signUp(SignUpModel user) async {
  //   setLoading(true);
  //   setErrorMessage(null);
  //   try {
  //     if (!_validateRequiredFields(user)) {
  //       setErrorMessage('Please fill in all required fields.');
  //       setLoading(false);
  //       return false;
  //     }
  //     if (user.birthDate != null && user.birthDate!.isNotEmpty) {
  //       final parsedDate = DateTime.tryParse(user.birthDate!);
  //       if (parsedDate == null) {
  //         setErrorMessage(
  //           'Invalid birth date format. Please use YYYY-MM-DD format.',
  //         );
  //         setLoading(false);
  //         return false;
  //       }
  //       user.birthDate = DateFormat(ConstValue.dateFormate).format(parsedDate);
  //     } else {
  //       setErrorMessage('Birth date is required.');
  //       setLoading(false);
  //       return false;
  //     }
  //     final client = createHttpClient();
  //     final url = Uri.parse('$baseUrl/Auth/signup');
  //     final Map<String, dynamic> userJson = {
  //       'email': user.email?.trim(),
  //       'password': user.password?.trim(),
  //       'phonenum': user.phonenum?.trim(),
  //       'firstname': user.firstname?.trim(),
  //       'lastname': user.lastname?.trim(),
  //       'birthDate': user.birthDate?.trim(),
  //     };
  //     debugPrint('Sending sign up request to: $url');
  //     debugPrint('Request body: ${jsonEncode(userJson)}');
  //     final response = await client.post(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //       },
  //       body: jsonEncode(userJson),
  //     );
  //     setLoading(false);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return true;
  //     } else {
  //       final errorResponse = jsonDecode(response.body);
  //       final errorMsg =
  //           errorResponse['message'] ??
  //           errorResponse['error'] ??
  //           'Registration failed.';
  //       setErrorMessage(errorMsg);
  //       return false;
  //     }
  //   } catch (e) {
  //     debugPrint('Error during sign up: $e');
  //     setErrorMessage('Unexpected error occurred: $e');
  //     setLoading(false);
  //     return false;
  //   }
  // }

  // bool _validateRequiredFields(SignUpModel user) {
  //   return user.email?.isNotEmpty == true &&
  //       user.password?.isNotEmpty == true &&
  //       user.firstname?.isNotEmpty == true &&
  //       user.lastname?.isNotEmpty == true &&
  //       user.birthDate?.isNotEmpty == true;
  // }

  Future<bool> resetPassword(ResetPasswordModel resetData) async {
    setLoading(true);
    setErrorMessage(null);

    try {
      final emailParam = resetData.email.trim();
      debugPrint("Resetting password for email: $emailParam");

      final client = createHttpClient();
      final uri = Uri.parse(
        '$baseUrl/Auth/SendOTP-To-ResetPassword',
      ).replace(queryParameters: {'email': emailParam});

      debugPrint("Request URI: $uri");

      final response = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: '',
      );

      setLoading(false);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        final errorResponse = jsonDecode(response.body);
        final errorMessage =
            errorResponse['message'] ??
                errorResponse['error'] ??
                'Password reset failed.';
        setErrorMessage(errorMessage);
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