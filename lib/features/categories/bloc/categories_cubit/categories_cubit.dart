import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/product/data/response/products_response.dart';
import 'package:sadaf/generated/assets.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../generated/l10n.dart';
import '../../data/response/category.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesInitial> {
  CategoriesCubit() : super(CategoriesInitial.initial());

  Future<void> getCategories({int? subId}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, subId: subId));

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
      path: state.subId == 0 ? null : state.subId.toString(),
    );

    if (response.statusCode == 200) {
      return Pair(Categories.fromJson(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }

  void selectCategory(int id) =>
      emit(state.copyWith(selectedId: id, error: getRandomString(5)));

  bool isSelected(int id) => id == state.selectedId;
}
