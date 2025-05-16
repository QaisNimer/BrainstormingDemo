import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';

import '../../model/auth_model/signup_model.dart';
import '../core/const_values.dart';

class SignUpController extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  http.Client createHttpClient() {
    final httpClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    return IOClient(httpClient);
  }

  // The date validation is no longer needed as we're using the date picker
  // and formatting directly in ISO format in the UI

  Future<bool> registerUser(SignUpModel user) async {
    setLoading(true);
    setErrorMessage('');

    try {
      // Validate required fields
      if (user.email?.isEmpty == true ||
          user.password?.isEmpty == true ||
          user.firstname?.isEmpty == true ||
          user.lastname?.isEmpty == true) {
        setErrorMessage('Please fill all required fields');
        setLoading(false);
        return false;
      }

      // Validate birth date
      if (user.birthDate == null || user.birthDate!.isEmpty) {
        setErrorMessage('Birth date is required');
        setLoading(false);
        return false;
      }

      // No need to validate date format as we're using a date directly from the date picker
      // already in ISO format

      final client = createHttpClient();
      final Uri url = Uri.parse('${ConstValue.baseUrl}api/Auth/signup');

      // Create request body
      Map<String, dynamic> requestBody = {
        'email': user.email?.trim(),
        'password': user.password?.trim(),
        'phonenum': user.phonenum?.trim(),
        'firstname': user.firstname?.trim(),
        'lastname': user.lastname?.trim(),
        'birthDate': user.birthDate?.trim(), // Already in correct ISO format from UI
      };

      log('Sending sign up request to: $url');
      log('Request body: ${jsonEncode(requestBody)}');

      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      setLoading(false);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        Map<String, dynamic> errorResponse;
        try {
          errorResponse = jsonDecode(response.body);
          if (errorResponse.containsKey('errors')) {
            // Handle structured validation errors
            if (errorResponse['errors'].containsKey(r'$.birthDate')) {
              // Handle the error for birthDate
              setErrorMessage('Invalid birth date format');
            } else if (errorResponse['errors'].containsKey('input')) {
              setErrorMessage('Invalid input: ${errorResponse['errors']['input'][0]}');
            } else {
              setErrorMessage(errorResponse['title'] ?? 'Registration failed');
            }
          } else {
            setErrorMessage(errorResponse['message'] ?? 'Registration failed');
          }
        } catch (e) {
          setErrorMessage('Registration failed: ${response.body}');
        }
        return false;
      }
    } catch (e) {
      log('Error during registration: $e');
      setErrorMessage('Unexpected error: $e');
      setLoading(false);
      return false;
    }
  }
}