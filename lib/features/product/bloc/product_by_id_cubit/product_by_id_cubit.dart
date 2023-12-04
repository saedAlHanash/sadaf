import 'package:bloc/bloc.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/abstraction.dart';
import 'package:sadaf/features/product/data/response/products_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'product_by_id_state.dart';

class ProductByIdCubit extends Cubit<ProductByIdInitial> {
  ProductByIdCubit() : super(ProductByIdInitial.initial());

  Future<void> getProductById({required int id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, id: id));
    final pair = await _getProductByIdApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }


  Future<Pair<Product?, String?>> _getProductByIdApi() async {
    final response = await APIService().getApi(
      url: GetUrl.productById,
      path: state.id.toString(),
    );

    if (response.statusCode == 200) {
      return Pair(Product.fromJson(response.jsonBody['data']), null);
    } else {
      return response.getPairError;
    }
  }
}
