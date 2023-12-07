import 'package:bloc/bloc.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'remove_from_cart_state.dart';

class RemoveFromCartCubit extends Cubit<RemoveFromCartInitial> {
  RemoveFromCartCubit() : super(RemoveFromCartInitial.initial());

  Future<void> removeFromCart({required int productId}) async {
    if (productId == 0) return;

    emit(state.copyWith(
      statuses: CubitStatuses.loading,
      id: productId,
    ));

    final pair = await _removeFromCartApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
      // ctx?.read<>()
    }
  }

  Future<Pair<bool?, String?>> _removeFromCartApi() async {
    final response = await APIService().deleteApi(
      url: DeleteUrl.removeFromCart,
      body: {'product_id': state.id},
      path: state.id.toString(),
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
