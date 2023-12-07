import 'package:bloc/bloc.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/fav_response.dart';

part 'get_favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteInitial> {
  FavoriteCubit() : super(FavoriteInitial.initial());

  Future<void> getFavorite() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _getFavoriteApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  static Future<Pair<List<Fav>?, String?>> _getFavoriteApi() async {
    final response = await APIService().getApi(url: GetUrl.favorite);

    if (response.statusCode == 200) {
      return Pair(
        FavResponse.fromJson(response.jsonBody).data,
        null,
      );
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  void remove({required int id}) {
    state.result.removeWhere((e) => e.id == id);

    emit(state.copyWith(result: state.result, statuses: CubitStatuses.loading));
    Future.delayed(
      const Duration(seconds: 1),
      () {
        emit(state.copyWith(result: state.result,statuses: CubitStatuses.done));
      },
    );
  }
}
