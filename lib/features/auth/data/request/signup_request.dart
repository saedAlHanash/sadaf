import 'package:flutter/material.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/snack_bar_message.dart';
import '../../../../main.dart';

class SignupRequest {
  SignupRequest({
    this.name = '',
    this.phoneNumber = '',
    this.address = '',
    this.password = '',
    this.rePassword = '',
    this.fcmToken = '',
    this.city = '',
    this.country = '',
  });

  String name;
  String phoneNumber;
  String address;
  String password;
  String rePassword;
  String fcmToken;
  String city;
  String country;

  //--------
  bool? isAcceptPolicy = false;

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phoneNumber.fixPhone(),
        "address": address,
        "password": password,
        "fcm_token": fcmToken,
        "city": city,
        "country": country,
        "password_confirmation": rePassword,
      };

  bool validateFirst(BuildContext context) {
    if (name.isEmpty) {
      NoteMessage.showErrorSnackBar(context: context, message: 'يرجى إدخال الاسم');
      return false;
    }
    if (phoneNumber.isEmpty) {
      NoteMessage.showErrorSnackBar(context: context, message: 'يرجى إدخال رقم الهاتف');
      return false;
    }
    if (password.isEmpty) {
      NoteMessage.showErrorSnackBar(context: context, message: 'يرجى إدخال كلمة السر');
      return false;
    }
    if (rePassword.isEmpty) {
      NoteMessage.showErrorSnackBar(
          context: context, message: 'يرجى إدخال تأكيد كلمة السر');
      return false;
    }
    if (rePassword != password) {
      NoteMessage.showErrorSnackBar(context: context, message: 'كلمة السر غير مطابقة');
      return false;
    }
    if (!(isAcceptPolicy ?? false)) {
      NoteMessage.showErrorSnackBar(
          context: context, message: 'للمتابعة يجب الموافقة على سياسة الخصوصية');
      return false;
    }

    var f = phoneNumber.checkPhoneNumber(context, phoneNumber);

    if (f == null) return false;

    phoneNumber = f;

    return true;
  }

  Future<bool> validateSecond(BuildContext context) async {
    fcmToken = await getFireToken();

    if (address.isEmpty && context.mounted) {
      NoteMessage.showErrorSnackBar(context: context, message: 'يرجى إدخال العنوان');
      return false;
    }
    if (city.isEmpty && context.mounted) {
      NoteMessage.showErrorSnackBar(context: context, message: 'يرجى إدخال المنطقة');
      return false;
    }
    if (country.isEmpty && context.mounted) {
      NoteMessage.showErrorSnackBar(context: context, message: 'يرجى إدخال المحتفظة');
      return false;
    }
    return true;
  }
}
