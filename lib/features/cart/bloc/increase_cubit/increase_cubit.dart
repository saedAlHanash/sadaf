import 'package:bloc/bloc.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'increase_state.dart';

class IncreaseCubit extends Cubit<IncreaseInitial> {
  IncreaseCubit() : super(IncreaseInitial.initial());

  Future<void> increase({required int productId}) async {
    if (productId == 0) return;

    emit(state.copyWith(
      statuses: CubitStatuses.loading,
      id: productId,
    ));

    final pair = await _increaseApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));

      emit(IncreaseInitial.initial());
      //TODO: get cart hear
      // ctx?.read<>()
    }
  }

  Future<Pair<bool?, String?>> _increaseApi() async {
    final response = await APIService().postApi(
      url: PostUrl.increase(state.id),
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }


  void goToCart(bool c) {
    emit(state.copyWith(goToCart: c));
    Future.delayed(
      const Duration(seconds: 1),
      () => emit(state.copyWith(goToCart: false)),
    );
  }
}
