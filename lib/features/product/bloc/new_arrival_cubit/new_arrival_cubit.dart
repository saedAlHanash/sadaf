import 'package:bloc/bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/product/data/response/products_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';

part 'new_arrival_state.dart';

class NewArrivalProductsCubit extends Cubit<NewArrivalProductsInitial> {
  NewArrivalProductsCubit() : super(NewArrivalProductsInitial.initial());

  Future<void> getNewArrivalProducts() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _getNewArrivalProductsApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      state.command.fromMeta(meta: pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first!.data));
    }
  }

  Future<Pair<ProductsResponse?, String?>> _getNewArrivalProductsApi() async {
    final response = await APIService().getApi(
      url: GetUrl.newArrivalProducts,
    );

    if (response.statusCode == 200) {
      return Pair(ProductsResponse.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }
}
