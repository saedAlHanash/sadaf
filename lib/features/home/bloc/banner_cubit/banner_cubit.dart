import 'package:bloc/bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/home_response.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerInitial> {
  BannerCubit() : super(BannerInitial.initial());
  

  Future<void> getBanner() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getBannerApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<BannerModel>?, String?>> _getBannerApi() async {
    final response = await APIService().getApi(
      url: GetUrl.banners,
    );

    if (response.statusCode == 200) {
      return Pair(BannersResponse.fromJson(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }
}
