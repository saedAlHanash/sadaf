import 'package:bloc/bloc.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/orders_response.dart';

part 'order_by_id_state.dart';

class OrderByIdCubit extends Cubit<OrderByIdInitial> {
  OrderByIdCubit() : super(OrderByIdInitial.initial());

  Future<void> getOrderById({required int id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, id: id));
    final pair = await _getOrderByIdApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }


  Future<Pair<Order?, String?>> _getOrderByIdApi() async {
    final response = await APIService().getApi(
      url: GetUrl.orderById,
      path: state.id.toString(),
    );

    if (response.statusCode == 200) {
      return Pair(Order.fromJson(response.jsonBody['data']), null);
    } else {
      return response.getPairError;
    }
  }
}
