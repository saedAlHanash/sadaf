import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/response/category.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesInitial> {
  CategoriesCubit() : super(CategoriesInitial.initial());

  Future<void> getCategories() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _getCategoriesApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Category>?, String?>> _getCategoriesApi() async {
    final response = await APIService().getApi(
      url: GetUrl.categories,
    );

    if (response.statusCode == 200) {
      return Pair(Categories.fromJson(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }

  void selectCategory(int id) {
    emit(state.copyWith(selectedId: id, error: getRandomString(5)));
  }

  bool isSelected(int id) => id == state.selectedId;
}
