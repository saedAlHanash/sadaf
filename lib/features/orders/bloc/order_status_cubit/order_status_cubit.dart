import 'package:bloc/bloc.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/order_status_response.dart';
import '../../data/response/orders_response.dart';

part 'order_status_state.dart';

class OrderStatusCubit extends Cubit<OrderStatusInitial> {
  OrderStatusCubit() : super(OrderStatusInitial.initial());

  Future<void> getOrderStatus({required int id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, id: id));
    final pair = await _getOrderStatusApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<OrderStatusResult>?, String?>> _getOrderStatusApi() async {
    final response = await APIService().getApi(
      url: GetUrl.orderStatus,
      path: state.id.toString(),
    );

    if (response.statusCode == 200) {
      return Pair(OrderStatusResponse.fromJson(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }
}
