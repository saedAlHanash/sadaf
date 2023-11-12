import 'package:sadaf/core/util/shared_preferences.dart';

class ResetPasswordRequest {
  ResetPasswordRequest({
    this.password,
    this.passwordConfirmation,
  });

  String? password;
  String? passwordConfirmation;

  Map<String, dynamic> toJson() => {
        "email_or_phone": AppSharedPreference.getPhoneOrEmailPassword,
        "otp_code": AppSharedPreference.getOtpPassword,
        "password": password,
        "password_confirmation": passwordConfirmation,
      };
}
