class Verfication_Model {
  String? email;
  String? otpCode;
  bool? isSignup;

  Verfication_Model({this.email, this.otpCode, this.isSignup});

  Verfication_Model.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    otpCode = json['otpCode'];
    isSignup = json['isSignup'];
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otpCode': otpCode,
      'isSignup': isSignup,
    };
  }
}
