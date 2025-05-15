import 'dart:convert';
import 'dart:io';
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

  Future<bool> registerUser(SignUpModel user) async {
    setLoading(true);
    setErrorMessage('');

    try {
      final client = createHttpClient();
      final Uri url = Uri.parse('${ConstValue.baseUrl}api/Auth/signup');

      // Format birthDate from dd/MM/yyyy to yyyy-MM-dd
      String? formattedBirthDate;
      if (user.birthDate != null && user.birthDate!.isNotEmpty) {
        try {
          final parsedDate = DateFormat('dd/MM/yyyy').parse(user.birthDate!);
          formattedBirthDate = DateFormat('yyyy-MM-dd').format(parsedDate);
        } catch (e) {
          setErrorMessage('Invalid birth date format');
          setLoading(false);
          return false;
        }
      }

      final body = jsonEncode({
        "email": user.email?.trim(),
        "password": user.password?.trim(),
        "phone_number": user.phonenum?.trim(),
        "first_name": user.firstname?.trim(),
        "last_name": user.lastname?.trim(),
        "birth_date": formattedBirthDate,
      });

      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      setLoading(false);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        final resBody = jsonDecode(response.body);
        setErrorMessage(resBody['message'] ?? 'Registration failed');
        return false;
      }
    } catch (e) {
      setErrorMessage('Unexpected error: $e');
      setLoading(false);
      return false;
    }
  }
}
