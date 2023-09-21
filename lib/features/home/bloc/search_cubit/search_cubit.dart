import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../product/data/models/product.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchInitial> {
  SearchCubit() : super(SearchInitial.initial());

  final network = sl<NetworkInfo>();

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
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.search,
        query: {'search': searchKey},
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return Pair(
          json["data"] == null
              ? []
              : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x ?? {}))),
          null,
        );
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
