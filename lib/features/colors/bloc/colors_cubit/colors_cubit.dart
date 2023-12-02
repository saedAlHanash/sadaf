import 'package:bloc/bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/colors/data/response/color_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';

part 'colors_state.dart';

class ColorsCubit extends Cubit<ColorsInitial> {
  ColorsCubit() : super(ColorsInitial.initial());

  Future<void> getColors() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _getColorsApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<ColorModel>?, String?>> _getColorsApi() async {
    final response = await APIService().getApi(
      url: GetUrl.colors,
    );

    if (response.statusCode == 200) {
      return Pair(ColorsResponse.fromJson(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }

  void selectCategory(int id) =>
      emit(state.copyWith(selectedId: id, error: getRandomString(5)));

  bool isSelected(int id) => id == state.selectedId;
}
