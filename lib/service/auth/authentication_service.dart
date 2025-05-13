import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/const_values.dart';
import '../../model/sign_model.dart';


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




























}