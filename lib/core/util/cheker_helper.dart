import 'package:flutter/cupertino.dart';
import 'package:sadaf/core/util/snack_bar_message.dart';

import '../strings/app_string_manager.dart';



bool checkEmail(String? email) {
  final bool emailValid =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email ?? '');
  return emailValid;
}
