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

  Future<void> createOrder({ int? productId}) async {
    if (productId == 0) return;

    emit(state.copyWith(
      statuses: CubitStatuses.loading,
      id: productId,
    ));

    final pair = await _createOrderApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
      // ctx?.read<>()
    }
  }

  Future<Pair<bool?, String?>> _createOrderApi() async {
    final response = await APIService().postApi(
      url: PostUrl.createOrder,
      // body: {'product_id': state.id},
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
