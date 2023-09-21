import 'package:bloc/bloc.dart';
import 'package:sadaf/core/api_manager/api_service.dart';
import 'package:sadaf/features/settings/services/setting_service.dart';

import '../../../../core/injection/injection_container.dart';
import '../../service/cart_service.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartInitial> {
  CartCubit() : super(CartInitial.initial());

  void getDeliveryPrice() async {
    final deliveryPrice = await sl<SettingService>().getDeliveryPrice();
    final subTotal = sl<CartService>().getTotal();
    final total = subTotal + deliveryPrice;

    emit(state.copyWith(
      deliveryPrice: deliveryPrice,
      subTotal: subTotal,
      total: total,
    ));
  }

  void changeQuantity() async {
    final deliveryPrice = await sl<SettingService>().getDeliveryPrice();
    final subTotal = sl<CartService>().getTotal();
    final total = subTotal + deliveryPrice;

    loggerObject.wtf('updated');
    emit(state.copyWith(
      subTotal: subTotal,
      total: total,
    ));
  }
}
