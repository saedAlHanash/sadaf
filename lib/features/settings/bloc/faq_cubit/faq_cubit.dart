import 'package:bloc/bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/faq_response.dart';

part 'faq_state.dart';

class FaqCubit extends Cubit<FaqInitial> {
  FaqCubit() : super(FaqInitial.initial());

  Future<void> getFaq() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _getFaqApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Faq>?, String?>> _getFaqApi() async {
    final response = await APIService().getApi(
      url: GetUrl.faq,
    );

    if (response.statusCode == 200) {
      return Pair(FaqResponse.fromJson(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }

  void selectCategory(int id) =>
      emit(state.copyWith(selectedId: id, error: getRandomString(5)));

  bool isSelected(int id) => id == state.selectedId;
}
