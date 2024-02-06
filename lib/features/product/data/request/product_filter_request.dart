import 'package:sadaf/core/strings/enum_manager.dart';
import 'package:sadaf/core/util/shared_preferences.dart';

class ProductFilterRequest {
  ProductFilterRequest({
    this.fromPrice,
    this.toPrice,
    this.categoryId,
    this.subCategoryId,
    this.colorId,
    this.search,
  });

  num? fromPrice;
  num? toPrice;
  int? categoryId;
  int? subCategoryId;
  int? colorId;
  String? search;

  factory ProductFilterRequest.fromJson(Map<String, dynamic> map) {
    return ProductFilterRequest(
      fromPrice: map['fromPrice'] ?? 0,
      toPrice: map['toPrice'] ?? 0,
      categoryId: map['category_id'] ?? 0,
      subCategoryId: map['sub_category_id'] ?? 0,
      colorId: map['color_id'] ?? 0,
      search: map['search'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fromPrice': fromPrice,
      'toPrice': toPrice,
      'category_id': categoryId,
      'sub_category_id': subCategoryId,
      'color_id': colorId,
      'search': search,
    };
  }

}

num get min => AppSharedPreference.currency == CurrencyEnum.dinar ? 0.0 : 0.0;

num get max => AppSharedPreference.currency == CurrencyEnum.dinar ? 300000.0 : 3000.0;

double get step => AppSharedPreference.currency == CurrencyEnum.dinar ? 100.0 : 10.0;
