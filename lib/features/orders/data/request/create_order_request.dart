import 'package:collection/collection.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../cart/service/cart_service.dart';

class CreateOrderRequest {
  String? couponCode;

  CreateOrderRequest({
    this.couponCode,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'coupon_code': couponCode,
    };

    final list = sl<CartService>().getCartProducts();

    map['item_count'] = list.length.toString();
    list.forEachIndexed((i, e) {
      map['product_id_${i + 1}'] = list[i].id.toString();
      map['quantity_${i + 1}'] = list[i].quantity.toString();
    });

    return map;
  }

}
