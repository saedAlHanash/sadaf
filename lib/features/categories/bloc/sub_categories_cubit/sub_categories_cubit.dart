import 'package:bloc/bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/category.dart';

part 'sub_categories_state.dart';

class SubCategoriesCubit extends Cubit<SubCategoriesInitial> {
  SubCategoriesCubit() : super(SubCategoriesInitial.initial());

  Future<void> getSubCategories({required int? subId}) async {
    if (subId == null) return;

    emit(state.copyWith(statuses: CubitStatuses.loading, subId: subId));

    final pair = await _getSubCategoriesApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Category>?, String?>> _getSubCategoriesApi() async {
    final response = await APIService().getApi(
      url: GetUrl.subCategories,
      path: state.subId.toString(),
    );

    if (response.statusCode == 200) {
      return Pair(Categories.fromJson(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }

  void selectCategory(int id) => emit(
        state.copyWith(selectedId: id, error: getRandomString(5)),
      );

  bool isSelected(int id) => id == state.selectedId;
}
