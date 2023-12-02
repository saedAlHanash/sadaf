import 'package:bloc/bloc.dart';

import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

import '../../data/response/home_response.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderInitial> {
  SliderCubit() : super(SliderInitial.initial());
  

  Future<void> getSlider() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getSliderApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<BannerModel>?, String?>> _getSliderApi() async {
    final response = await APIService().getApi(
      url: GetUrl.slider,
    );

    if (response.statusCode == 200) {
      return Pair(BannersResponse.fromJson(response.jsonBody).data, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
