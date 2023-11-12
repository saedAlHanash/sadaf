import 'package:sadaf/core/util/shared_preferences.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';

class UpdateProfileRequest {
  UpdateProfileRequest({
    this.name,
    this.emailOrPhone,
    this.mapAddress,
    this.country,
    this.city,
    this.homeAddress,
    this.oldPass,
    this.newPass,
    this.rePass,
  });

  String? country;
  String? city;
  String? homeAddress;
  String? name;
  String? emailOrPhone;
  String? mapAddress;
  UploadFile? avatar;

  String? oldPass;
  String? newPass;
  String? rePass;

  UpdateType? type;

  factory UpdateProfileRequest.initial() {
    final user = AppSharedPreference.getUserModel;
    return UpdateProfileRequest(
      name: user.name,
      emailOrPhone: user.emailOrPhone,
      mapAddress: user.mapAddress,
      country: user.country,
      city: user.city,
      homeAddress: user.mapAddress,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email_or_phone": emailOrPhone,
        "map_address": mapAddress,
        "address[country]": country,
        "address[city]": city,
        "address[home_address]": homeAddress,
        "old_password": oldPass,
        "new_password": newPass,
        "new_password_confirmation": rePass,
      };
}
