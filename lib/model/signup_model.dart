class SignupModel {
  final bool status;
  final String message;
  final String? token;

  SignupModel({
    required this.status,
    required this.message,
    this.token,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      token: json['token'],
    );
  }
}
