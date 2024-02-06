import 'package:sadaf/core/api_manager/api_service.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../data/response/terms_response.dart';

class SettingService {
  num deliveryPrice = 0;
  var about = '';
  var privacy = '';
  var whatsUp = '';
  var facebook = '';
  var phone = '';

  Future<num> getDeliveryPrice() async {
    if (deliveryPrice > 0) return deliveryPrice;
    final result = await APIService().getApi(
      url: GetUrl.setting,
      query: {'key': 'deliveryPrice'},
    );
    if (result.statusCode.success) {
      var val = result.jsonBody['data']['value'];
      deliveryPrice = num.parse(val);
      return deliveryPrice;
    }
    return -1;
  }

  Future<String> getAbout() async {
    if (about.isNotEmpty) return about;
    final result = await APIService().getApi(
      url: GetUrl.setting,
    );
    if (result.statusCode.success) {
      about = result.jsonBody['data']['description'] ?? '';
      return about;
    }
    return about;
  }

  Future<List<Terms>?> getPrivacy() async {
    final result = await APIService().getApi(
      url: GetUrl.termsAndConditions,
    );
    if (result.statusCode.success) {
      return TermsResponse.fromJson(result.jsonBody).data;
    }
    return null;
  }

  Future<String> getWhatsUp() async {
    if (whatsUp.isNotEmpty) return whatsUp;
    final result = await APIService().getApi(
      url: GetUrl.setting,
      query: {'key': 'whatsUp'},
    );
    if (result.statusCode.success) {
      whatsUp = result.jsonBody['data']['value'];
      return whatsUp;
    }
    return whatsUp;
  }

  Future<String> getFacebook() async {
    if (facebook.isNotEmpty) return facebook;
    final result = await APIService().getApi(
      url: GetUrl.setting,
      query: {'key': 'facebook'},
    );
    if (result.statusCode.success) {
      facebook = result.jsonBody['data']['value'];
      return facebook;
    }
    return facebook;
  }

  Future<String> getPhone() async {
    if (phone.isNotEmpty) return phone;
    final result = await APIService().getApi(
      url: GetUrl.setting,
      query: {'key': 'phone'},
    );
    if (result.statusCode.success) {
      phone = result.jsonBody['data']['value'];
      return phone;
    }
    return phone;
  }
}
