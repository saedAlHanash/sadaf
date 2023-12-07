import 'package:bloc/bloc.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'clear_cart_state.dart';

class ClearCartCubit extends Cubit<ClearCartInitial> {
  ClearCartCubit() : super(ClearCartInitial.initial());

  Future<void> clearCart({ int? productId}) async {
    if (productId == 0) return;

    emit(state.copyWith(
      statuses: CubitStatuses.loading,
      id: productId,
    ));

    final pair = await _clearCartApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
      // ctx?.read<>()
    }
  }

  Future<Pair<bool?, String?>> _clearCartApi() async {
    final response = await APIService().deleteApi(
      url: DeleteUrl.clearCart,
      body: {'product_id': state.id},
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
