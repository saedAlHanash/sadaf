import 'package:bloc/bloc.dart';
import 'package:sadaf/core/api_manager/api_service.dart';

import '../../../../core/injection/injection_container.dart';
import '../../service/cart_service.dart';

part 'update_cart_state.dart';

class UpdateCartCubit extends Cubit<UpdateCartInitial> {
  UpdateCartCubit() : super(UpdateCartInitial.initial());

  void updateCart() {
    final count = sl<CartService>().getCounts;
    loggerObject.w(count);
    emit(UpdateCartInitial(result: count));
  }

}
