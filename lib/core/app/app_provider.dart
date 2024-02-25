import 'package:sadaf/features/profile/data/response/profile_response.dart';

import '../util/shared_preferences.dart';

class AppProvider {
  static var _profile = AppSharedPreference.getProfile;

  static Profile get profile => _profile;

  static Future<void> cashProfile(Profile profile) async {
    await AppSharedPreference.setProfile(profile);
    _profile = AppSharedPreference.getProfile;
  }

  static Future<void> logout() async {
    await  AppSharedPreference.logout();

    _profile = AppSharedPreference.getProfile;
  }
}
