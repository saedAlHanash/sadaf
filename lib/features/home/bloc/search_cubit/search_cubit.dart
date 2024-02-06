import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../product/data/response/products_response.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchInitial> {
  SearchCubit() : super(SearchInitial.initial());

  

  Future<void> getSearch(BuildContext context, {required String searchKey}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _addSearchApi(searchKey: searchKey);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Product>?, String?>> _addSearchApi({required String searchKey}) async {
     
      final response = await APIService().getApi(
        url: GetUrl.search,
        query: {'search': searchKey},
      );

      if (response.statusCode == 200) {
        var json = response.jsonBody;
        return Pair(
          json["data"] == null
              ? []
              : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x ?? {}))),
          null,
        );
      } else {
      return response.getPairError;
      }
     
  }
}
