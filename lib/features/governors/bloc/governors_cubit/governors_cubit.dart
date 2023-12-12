import 'package:bloc/bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/widgets/spinner_widget.dart';
import 'package:sadaf/features/governors/data/response/governor_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';

part 'governors_state.dart';

class GovernorsCubit extends Cubit<GovernorsInitial> {
  GovernorsCubit() : super(GovernorsInitial.initial());

  Future<void> getGovernors() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _getGovernorsApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<GovernorModel>?, String?>> _getGovernorsApi() async {
    final response = await APIService().getApi(
      url: GetUrl.governors,
    );

    if (response.statusCode == 200) {
      return Pair(GovernorsResponse.fromJson(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }

  void selectCategory(int id) =>
      emit(state.copyWith(selectedId: id, error: getRandomString(5)));

  bool isSelected(int id) => id == state.selectedId;
}
