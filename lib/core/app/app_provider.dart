import 'package:sadaf/features/profile/data/response/profile_response.dart';

import '../util/shared_preferences.dart';

class AppProvider {
  static var _profile = AppSharedPreference.getProfile;

  static Profile get profile => _profile;

 static  void reInitial() {
    _profile = AppSharedPreference.getProfile;
  }
}
