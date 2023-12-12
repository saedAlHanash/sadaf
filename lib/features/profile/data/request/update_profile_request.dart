import 'package:sadaf/core/util/shared_preferences.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../response/profile_response.dart';

class UpdateProfileRequest {
  UpdateProfileRequest({
    this.name,
    this.emailOrPhone,
    this.mapAddress,
    this.receiverPhone,
    this.governorId,
    this.address,
    this.oldPass,
    this.newPass,
    this.rePass,
  });

  String? receiverPhone;
  int? governorId;
  String? address;
  String? name;
  String? emailOrPhone;
  MapAddress? mapAddress;

  UploadFile? avatar;
  String? oldPass;
  String? newPass;
  String? rePass;

  UpdateType? type;

  factory UpdateProfileRequest.initial() {
    final user = AppSharedPreference.getProfile;
    return UpdateProfileRequest(
      name: user.name,
      emailOrPhone: user.emailOrPhone,
      mapAddress: user.mapAddress,
      receiverPhone: user.receiverPhone,
      governorId: user.governor.id,
      address: user.address,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email_or_phone": emailOrPhone,
        "map_address": mapAddress?.toJson(),
        "address": address,
        "old_password": oldPass,
        "new_password": newPass,
        "receiver_phone": receiverPhone,
        "governor_id": governorId == 0 ? null : governorId,
        "new_password_confirmation": rePass,
      }..removeWhere((key, value) => value == null);
}
