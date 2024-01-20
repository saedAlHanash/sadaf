import 'package:bloc/bloc.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderInitial> {
  CreateOrderCubit() : super(CreateOrderInitial.initial());

  Future<void> createOrder({required PaymentMethod method}) async {
    emit(
      state.copyWith(statuses: CubitStatuses.loading, paymentMethod: method),
    );
    switch (state.paymentMethod) {
      case PaymentMethod.cash:
        _createOrderCashMethod();
        break;
      case PaymentMethod.ePay:
        _createOrderEPayMethod();
        break;
    }
  }

  Future<void> _createOrderCashMethod() async {
    final pair = await _createOrderApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
      // ctx?.read<>()
    }
  }

  Future<void> _createOrderEPayMethod() async {
    final pair = await _createEPaymentOrderApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, paymentUrl: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _createOrderApi() async {
    final response = await APIService().postApi(
      url: PostUrl.createOrder,
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }

  Future<Pair<String?, String?>> _createEPaymentOrderApi() async {
    final response = await APIService().postApi(
      url: PostUrl.createEPaymentOrder,
    );

    if (response.statusCode == 200) {
      return Pair(response.jsonBody['data']['payment_url'] ?? '', null);
    } else {
      return response.getPairError;
    }
  }
}
