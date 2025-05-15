class ForgetPasswordModel {
  String? newPassword;
  String? email;
  String? phoneNumber;
  String? otp;
  String? confirmPassword;

  ForgetPasswordModel(
      {this.newPassword,
        this.email,
        this.phoneNumber,
        this.otp,
        this.confirmPassword});

  ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    newPassword = json['newPassword'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    otp = json['otp'];
    confirmPassword = json['confirmPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['newPassword'] = this.newPassword;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['otp'] = this.otp;
    data['confirmPassword'] = this.confirmPassword;
    return data;
  }
}