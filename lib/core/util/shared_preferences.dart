import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/response/login_response.dart';
import '../../features/profile/data/response/profile_response.dart';
import '../../generated/l10n.dart';
import '../strings/enum_manager.dart';

class AppSharedPreference {
  static const _token = '1';
  static const _phoneNumber = '3';
  static const _toScreen = '4';
  static const _policy = '5';
  static const _user = '6';

  static const _fireToken = '8';
  static const _notificationCount = '9';
  static const _social = '10';
  static const _activeNoti = '11';
  static const _myId = '12';
  static const _cart = '13';
  static const _lang = '14';
  static const _phoneNumberPassword = '15';
  static const _otpPassword = '16';
  static const _currency = '-17';
  static const _profile = '19';


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

  static cashUser(LoginData? model) {
    if (model == null) return;

    _prefs.setString(_user, jsonEncode(model.toJson()));
  }

  static LoginData get getUserModel {
    var json = _prefs.getString(_user) ?? '{}';
    return LoginData.fromJson(jsonDecode(json));
  }

  static cashPhoneOrEmail(String? phone) async {
    if (phone == null) return;
    await _prefs.setString(_phoneNumber, phone);
  }

  static String get getPhoneOrEmail {
    return _prefs.getString(_phoneNumber) ?? '';
  }

  static cashPhoneOrEmailPassword(String? phone) async {
    if (phone == null) return;
    await _prefs.setString(_phoneNumberPassword, phone);
  }

  static String get getPhoneOrEmailPassword {
    return _prefs.getString(_phoneNumberPassword) ?? '';
  }

  static cashOtpPassword(String? otp) async {
    if (otp == null) return;
    await _prefs.setString(_otpPassword, otp);
  }

  static String get getOtpPassword {
    return _prefs.getString(_otpPassword) ?? '';
  }

  static void removePhoneOrEmail() {
    _prefs.remove(_phoneNumber);
    _prefs.remove(_phoneNumberPassword);
    _prefs.remove(_otpPassword);
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

  static bool get isLogin => getToken().isNotEmpty;

  static void cashFireToken(String token) {
    _prefs.setString(_fireToken, token);
  }

  static String getFireToken() {
    return _prefs.getString(_fireToken) ?? '';
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

  static void cashReadiedNotifications(int val) {
    _prefs.setInt(_notificationCount, val);
  }

  static int get getReadiedNotifications => _prefs.getInt(_notificationCount) ?? 0;

  static void cashMyId(int id) {
    _prefs.setInt(_myId, id);
  }

  static void updateCart(List<String> jsonCart) {
    _prefs.setStringList(_cart, jsonCart);
  }

  static List<String> getJsonListCart() => _prefs.getStringList(_cart) ?? <String>[];

  static int get getMyId => _prefs.getInt(_myId) ?? 0;

  static Future<void> cashLocal(String langCode) async {
    await _prefs.setString(_lang, langCode);
  }

  static String get getLocal => _prefs.getString(_lang) ?? 'en';

  static set setCurrency(CurrencyEnum currency) =>
      _prefs.setInt(_currency, currency.index);

  static CurrencyEnum get currency => CurrencyEnum.values[_prefs.getInt(_currency) ?? 0];

  static setProfile(Profile profile) async {
    await _prefs.setString(_profile, jsonEncode(profile.toJson()));
  }

  static Profile get getProfile {
    return Profile.fromJson(jsonDecode(_prefs.getString(_profile) ?? '{}'));
  }

  static String getLangName(BuildContext context) {
    final lang = getLocal;
    if (lang == 'en') return S.of(context).en;
    if (lang == 'ar') return S.of(context).ar;
    if (lang == 'ku') return S.of(context).ku;
    return '';
  }

}
