import 'dart:developer';

import 'package:foodtek/core/const_values.dart';
import 'package:intl/intl.dart';

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
    birthDate =
    json['birthDate'] != null ? _formatBirthDate(json['birthDate']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email?.trim();
    data['password'] = password?.trim();
    data['phonenum'] = phonenum?.trim();
    data['firstname'] = firstname?.trim();
    data['lastname'] = lastname?.trim();
    data['birthDate'] =
    birthDate?.isNotEmpty == true ? _formatBirthDate(birthDate!) : null;
    return data;
  }

  // Formatting birthDate from dd/MM/yyyy to yyyy-MM-dd
  static String _formatBirthDate(String date) {
    try {
      final parsedDate = DateFormat('dd/MM/yyyy').parse(date);

      log(DateFormat(ConstValue.dateFormate).format(parsedDate.toUtc()));

      return DateFormat(
        "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
      ).format(parsedDate.toUtc());
    } catch (e) {
      return date; // In case of an invalid format, return the original date
    }
  }
}