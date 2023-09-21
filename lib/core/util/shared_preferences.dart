import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sadaf/core/api_manager/api_service.dart';

import '../../features/auth/data/response/login_response.dart';
import '../../features/auth/data/response/user_model.dart';
import '../../features/cart/bloc/update_cart_cubit/update_cart_cubit.dart';
import '../injection/injection_container.dart';
import '../strings/enum_manager.dart';

class AppSharedPreference {
  static const _token = '1';
  static const _phoneNumber = '3';
  static const _toScreen = '4';
  static const _policy = '5';
  static const _user = '6';
  static const _forgetEmail = '7';
  static const _fireToken = '8';
  static const _notificationCount = '9';
  static const _social = '10';
  static const _activeNoti = '11';
  static const _myId = '12';
  static const _cart = '13';

  static late SharedPreferences _prefs;

  static init(SharedPreferences preferences) async {
    _prefs = preferences;
  }

  static cashToken(String? token) {
    if (token == null) return;

    _prefs.setString(_token, token);
  }

  static String getToken() {
    return _prefs.getString(_token) ?? '';
  }

  static cashUser(ConfirmCodeData? model) {
    if (model == null) return;

    _prefs.setString(_user, jsonEncode(model.toJson()));
  }

  static ConfirmCodeData getUserModel() {
    var json = _prefs.getString(_user) ?? '{}';
    return ConfirmCodeData.fromJson(jsonDecode(json));
  }

  static cashPhoneNumber(String phone) async {
    loggerObject.v(phone);
    await _prefs.setString(_phoneNumber, phone);
  }

  static String getPhoneNumber() {
    return _prefs.getString(_phoneNumber) ?? '';
  }

  static void removePhoneNumber() {
    _prefs.remove(_phoneNumber);
  }

  static cashToScreen(ToScreen appState) {
    _prefs.setInt(_toScreen, appState.index);
  }

  static ToScreen toScreen() {
    final index = _prefs.getInt(_toScreen) ?? 0;
    return ToScreen.values[index];
  }

  static cashAcceptPolicy(bool isAccept) {
    if (isAccept == false) cashToScreen(ToScreen.policy);

    _prefs.setBool(_policy, isAccept);
  }

  static bool isAcceptPolicy() {
    return _prefs.getBool(_policy) ?? false;
  }

  static void clear() {
    _prefs.clear();
  }

  static void logout() {
    _prefs.clear();
  }

  static void cashEmail({required String email}) {
    _prefs.setString(_forgetEmail, email);
  }

  static String getCashedEmail() {
    return _prefs.getString(_forgetEmail) ?? '';
  }

  static bool get isLogin => getToken().isNotEmpty;

  // return true;

  static void removeCashEmail() {
    _prefs.remove(_forgetEmail);
  }

  static void cashFireToken(String token) {
    _prefs.setString(_fireToken, token);
  }

  static String getFireToken() {
    return _prefs.getString(_fireToken) ?? '';
  }

  static void addNotificationCount() {
    var count = getNotificationCount() + 1;
    _prefs.setInt(_notificationCount, count);
  }

  static int getNotificationCount() {
    return _prefs.getInt(_notificationCount) ?? 0;
  }

  static void clearNotificationCount() {
    _prefs.setInt(_notificationCount, 0);
  }

  static bool isCachedSocial() {
    return (_prefs.getString(_social) ?? '').length > 10;
  }

  static void cashActiveNotification(bool val) {
    _prefs.setBool(_activeNoti, val);
  }

  static bool getActiveNotification() {
    return _prefs.getBool(_activeNoti) ?? true;
  }

  static void cashMyId(int id) {
    _prefs.setInt(_myId, id);
  }

  static void updateCart(List<String> jsonCart) {
    _prefs.setStringList(_cart, jsonCart);
  }

  static List<String> getJsonListCart() => _prefs.getStringList(_cart) ?? <String>[];

  static int get getMyId => _prefs.getInt(_myId) ?? 0;
}
