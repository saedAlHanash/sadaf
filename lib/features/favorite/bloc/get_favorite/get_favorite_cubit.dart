import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sadaf/features/home/data/response/home_response.dart';

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

part 'get_favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteInitial> {
  FavoriteCubit() : super(FavoriteInitial.initial());
  static final favIds = <int>[];

  Future<void> getFavorite(BuildContext context) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await getFavoriteApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(
        state.copyWith(statuses: CubitStatuses.done, result: pair.first, favIds: favIds),
      );
    }
  }

  static Future<Pair<List<Product>?, String?>> getFavoriteApi() async {
    final network = sl<NetworkInfo>();
    if (await network.isConnected) {
      final response = await APIService().getApi(url: GetUrl.favorite);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        final p = Pair(
          json["data"] == null
              ? <Product>[]
              : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x ?? {}))),
          null,
        );

        favIds.clear();

        for (var e in p.first) {
          favIds.add(e.id);
        }

        return p;
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
