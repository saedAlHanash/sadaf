import 'package:bloc/bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/product/data/response/products_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';

import '../../data/response/my_orders.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersInitial> {
  OrdersCubit() : super(OrdersInitial.initial());

  Future<void> getOrders() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _getOrdersApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      state.command.fromMeta(meta: pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first!.data));
    }
  }

  Future<Pair<OrdersResponse?, String?>> _getOrdersApi() async {
    final response = await APIService().getApi(
      url: GetUrl.orders,
    );

    if (response.statusCode == 200) {
      return Pair(OrdersResponse.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }
}

