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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email?.trim();
    data['password'] = password?.trim();
    data['phonenum'] = phonenum?.trim();
    data['firstname'] = firstname?.trim();
    data['lastname'] = lastname?.trim();
    data['birthDate'] = birthDate?.trim();
    return data;
  }
}