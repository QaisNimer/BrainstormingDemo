import 'package:foodtek/core/api/api_consumer.dart';
import 'package:foodtek/core/api/end_points.dart';
import '../model/signup_model.dart';

class AuthService {
  final ApiConsumer api;

  AuthService({required this.api});

  Future<SignupModel> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String dateOfBirth,
  }) async {
    final response = await api.post(
      EndPoints.signUp,
      data: {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "birth_date": dateOfBirth,
      },
    );
    return SignupModel.fromJson(response);
  }
}
