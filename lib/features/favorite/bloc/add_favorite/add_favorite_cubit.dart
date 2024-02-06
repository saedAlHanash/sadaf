import 'package:bloc/bloc.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../product/data/response/products_response.dart';

part 'add_favorite_state.dart';

class AddFavoriteCubit extends Cubit<AddFavoriteInitial> {
  AddFavoriteCubit() : super(AddFavoriteInitial.initial());

  Future<void> addFavorite({required Product product}) async {
    emit(state.copyWith(
      statuses: CubitStatuses.loading,
      product: product,
      isFav: !product.isFavorite,
    ));

    final pair =
        product.isFavorite ? await _removeFavoriteApi() : await _addFavoriteApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<void> removeFav({required int productId}) async {
    emit(state.copyWith(
      statuses: CubitStatuses.loading,
      product: Product.fromJson({"id":productId,"isFavorite":false}),
      isFav: false,
    ));

    final pair = await _removeFavoriteApi() ;

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _addFavoriteApi() async {
    final response = await APIService()
        .postApi(url: PostUrl.addFavorite, body: {'product_id': state.product.id});

    if (response.statusCode == 200) {
      state.product.isFavorite = true;
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }

  Future<Pair<bool?, String?>> _removeFavoriteApi() async {
    final response = await APIService()
        .deleteApi(url: DeleteUrl.removeFavorite, body: {'product_id': state.product.id});

    if (response.statusCode == 200) {
      state.product.isFavorite = false;
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
