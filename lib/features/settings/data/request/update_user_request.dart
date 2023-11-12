import 'package:sadaf/core/util/shared_preferences.dart';

import '../../../../core/strings/enum_manager.dart';

class UpdateUserRequest {
  String name;
  String address;
  String city;
  String country;
  String phone;
  String oldPass;
  String newPass;
  String rePass;
  final UpdateType updateType;

  UpdateUserRequest({
    this.name = '',
    required this.updateType,
    this.address = '',
    this.city = '',
    this.country = '',
    this.phone = '',
    this.oldPass = '',
    this.newPass = '',
    this.rePass = '',
  }) {
    final user = AppSharedPreference.getUserModel;

    name = user.name;
    address = user.mapAddress;
    city = user.city;
    country = user.country;
    phone = user.emailOrPhone;
  }

// UpdateType? get updateType {
//
//   if (_isUpdateName) return UpdateType.name;
//   if (_isUpdatePhone) return UpdateType.phone;
//   if (_isUpdateAddress) return UpdateType.address;
//
//   return null;
// }
//
// bool get _isUpdateName => name != AppSharedPreference.getUserModel.name;
//
// bool get _isUpdatePhone => phone != AppSharedPreference.getUserModel.phone;
//
// bool get _isUpdateAddress {
//   return address != AppSharedPreference.getUserModel.address ||
//       city != AppSharedPreference.getUserModel.city ||
//       country != AppSharedPreference.getUserModel.country;
// }
}
