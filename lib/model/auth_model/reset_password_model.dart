class ResetPasswordModel {
  final String email;

  ResetPasswordModel({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email.trim(),
    };
  }

  @override
  String toString() {
    return 'ResetPasswordModel(email: $email)';
  }
}