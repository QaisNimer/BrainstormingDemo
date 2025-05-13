class SignUpModel {
  String? email;
  String? password;
  String? phonenum;
  String? firstname;
  String? lastname;
  String? birthDate;

  SignUpModel({
    this.email,
    this.password,
    this.phonenum,
    this.firstname,
    this.lastname,
    this.birthDate,
  });

  SignUpModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    phonenum = json['phonenum'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    birthDate = json['birthDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email?.trim();
    data['password'] = this.password?.trim();
    data['phonenum'] = this.phonenum?.trim();
    data['firstname'] = this.firstname?.trim();
    data['lastname'] = this.lastname?.trim();
    data['birthDate'] = this.birthDate?.trim();
    return data;
  }
}