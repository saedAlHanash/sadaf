import 'package:bloc/bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/models/flash_deal.dart';

part 'flash_deal_state.dart';

class FlashDealsCubit extends Cubit<FlashDealsInitial> {
  FlashDealsCubit() : super(FlashDealsInitial.initial());

  Future<void> getFlashDeals() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getFlashDealsApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<FlashDeal>?, String?>> _getFlashDealsApi() async {
    final response = await APIService().getApi(
      url: GetUrl.flashDeals,
    );

    if (response.statusCode == 200) {
      return Pair(FlashDealResponse.fromJson(response.jsonBody).data, null);
    } else {
    return response.getPairError;
    }
  }
}
