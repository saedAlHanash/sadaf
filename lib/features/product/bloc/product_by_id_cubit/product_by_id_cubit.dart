import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/product/data/models/product.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../data/response/product_by_id_response.dart';

part 'product_by_id_state.dart';

class ProductByIdCubit extends Cubit<ProductByIdInitial> {
  ProductByIdCubit() : super(ProductByIdInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> getProductById(BuildContext context, {required int id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getProductByIdApi(id: id);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<ProductByIdResult?, String?>> _getProductByIdApi({required int id}) async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.productById,
        path: id.toString(),
      );

      if (response.statusCode == 200) {
        return Pair(ProductByIdResponse.fromJson(response.jsonBody).data, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
