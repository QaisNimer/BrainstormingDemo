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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['otpCode'] = this.otpCode;
    data['isSignup'] = this.isSignup;
    return data;
  }
}