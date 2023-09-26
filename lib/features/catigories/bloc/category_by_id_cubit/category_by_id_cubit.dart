import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/catigories/data/models/category.dart';
import 'package:sadaf/features/product/data/models/product.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../generated/l10n.dart';

part 'category_by_id_state.dart';

class CategoryByIdCubit extends Cubit<CategoryByIdInitial> {
  CategoryByIdCubit() : super(CategoryByIdInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> getCategory(BuildContext context, {required Category category}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getCategoryApi(id: category.id, isSub: category.isSub);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Product>?, String?>> _getCategoryApi(
      {required int id, required bool isSub}) async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: '${isSub ? GetUrl.subCategoryById : GetUrl.categoryById}/$id/products',
      );

      if (response.statusCode == 200) {
        final json = response.jsonBody;
        return Pair(
          List<Product>.from(
            json["data"] == null ? [] : json['data']!.map((e) => Product.fromJson(e)),
          ),
          null,
        );
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, S().noInternet);
    }
  }

  static Future<List<Category>> getSubCategoryApi({required int id, bool? isSub}) async {
    final network = sl<NetworkInfo>();
    if (isSub ?? false) return <Category>[];

    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: '${GetUrl.categoryById}/$id/subCat',
      );

      if (response.statusCode == 200) {
        final json = response.jsonBody;
        return List<Category>.from(
          json["data"] == null ? [] : json['data']!.map((e) => Category.fromJson(e)),
        );
      } else {
        return <Category>[];
      }
    } else {
      return <Category>[];
    }
  }
}
