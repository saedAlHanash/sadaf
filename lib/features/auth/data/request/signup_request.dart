import 'package:flutter/material.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/snack_bar_message.dart';

import '../../../../main.dart';

class SignupRequest {
  SignupRequest({
    this.name ,
    this.birthday,
    this.phoneOrEmail ,
    this.password ,
  });

  String? name;
  DateTime? birthday;
  String? phoneOrEmail;
  String? password;
  String? rePassword;


  //--------
  bool? isAcceptPolicy = false;

  Map<String, dynamic> toJson() => {
        "name": name,
        "email_or_phone": phoneOrEmail,
        "dob": birthday?.toIso8601String(),
        "password": password,

      };

}
