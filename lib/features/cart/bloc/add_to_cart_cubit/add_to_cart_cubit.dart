import 'package:bloc/bloc.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartInitial> {
  AddToCartCubit() : super(AddToCartInitial.initial());

  Future<void> addToCart({required int productId}) async {
    if (productId == 0) return;

    emit(state.copyWith(
      statuses: CubitStatuses.loading,
      id: productId,
    ));

    final pair = await _addToCartApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
      doneAdd(id: state.id);
      //TODO: get cart hear
      // ctx?.read<>()
    }
  }

  Future<Pair<bool?, String?>> _addToCartApi() async {
    final response = await APIService().postApi(
      url: PostUrl.addToCart,
      body: {'product_id': state.id, "from": 'mobile'},
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }

  void doneAdd({int? id}) {
    emit(state.copyWith(showDone: true));
    Future.delayed(
      const Duration(seconds: 2),
      () {
        emit(state.copyWith(showDone: false));
      },
    );
  }

  void goToCart(bool c) {
    emit(state.copyWith(goToCart: c));
    Future.delayed(
      const Duration(seconds: 1),
      () => emit(state.copyWith(goToCart: false)),
    );
  }
}
