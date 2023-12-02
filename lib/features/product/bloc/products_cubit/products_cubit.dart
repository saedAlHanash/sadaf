import 'package:bloc/bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/product/data/response/products_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/product_filter_request.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsInitial> {
  ProductsCubit() : super(ProductsInitial.initial());

  Future<void> getProducts({ProductFilterRequest? request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));

    final pair = await _getProductsApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      state.command.fromMeta(meta: pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first!.data));
    }
  }

  Future<Pair<ProductsResponse?, String?>> _getProductsApi() async {
    final response = await APIService().getApi(
      url: GetUrl.products,
      query: state.request.toJson()..addAll(state.command.toJson() ?? {}),
    );

    if (response.statusCode == 200) {
      return Pair(ProductsResponse.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }
}
