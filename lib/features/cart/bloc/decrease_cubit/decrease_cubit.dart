import 'package:bloc/bloc.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'decrease_state.dart';

class DecreaseCubit extends Cubit<DecreaseInitial> {
  DecreaseCubit() : super(DecreaseInitial.initial());

  Future<void> decrease({required int productId}) async {
    if (productId == 0) return;

    emit(state.copyWith(
      statuses: CubitStatuses.loading,
      id: productId,
    ));

    final pair = await _decreaseApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
      emit(DecreaseInitial.initial());
    }
  }

  Future<Pair<bool?, String?>> _decreaseApi() async {
    final response = await APIService().postApi(
      url: PostUrl.decrease(state.id),
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }

}
