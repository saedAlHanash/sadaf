import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/models/offer.dart';

part 'offers_state.dart';

class OffersCubit extends Cubit<OffersInitial> {
  OffersCubit() : super(OffersInitial.initial());

  Future<void> getOffers(BuildContext context) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getOffersApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Offer>?, String?>> _getOffersApi() async {
    final response = await APIService().getApi(
      url: GetUrl.offers,
    );

    if (response.statusCode == 200) {
      return Pair(OffersDealResponse.fromJson(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }
}
