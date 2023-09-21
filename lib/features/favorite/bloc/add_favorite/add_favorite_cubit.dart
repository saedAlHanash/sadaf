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

part 'add_favorite_state.dart';

class AddFavoriteCubit extends Cubit<AddFavoriteInitial> {
  AddFavoriteCubit() : super(AddFavoriteInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> addFavorite(BuildContext context,
      {required Product product, required bool isFav}) async {
    emit(state.copyWith(
      statuses: CubitStatuses.loading,
      product: product,
      isFav: !isFav,
    ));

    final pair = isFav
        ? await _removeFavoriteApi(product: product)
        : await _addFavoriteApi(product: product);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _addFavoriteApi({required Product product}) async {
    if (await network.isConnected) {
      final response = await APIService()
          .postApi(url: PostUrl.addFavorite, query: {'product_id': product.id});

      if (response.statusCode == 200) {
        product.isFav = true;
        return Pair(true, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }

  Future<Pair<bool?, String?>> _removeFavoriteApi({required Product product}) async {
    if (await network.isConnected) {
      final response = await APIService()
          .deleteApi(url: DeleteUrl.removeFavorite, path: product.id.toString());

      if (response.statusCode == 200) {
        product.isFav = false;
        return Pair(true, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
