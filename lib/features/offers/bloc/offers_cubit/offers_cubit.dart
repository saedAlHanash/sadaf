import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../data/models/offer.dart';

part 'offers_state.dart';

class OffersCubit extends Cubit<OffersInitial> {
  OffersCubit() : super(OffersInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> getOffers(BuildContext context) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getOffersApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Offer>?, String?>> _getOffersApi() async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.offers,
      );

      if (response.statusCode == 200) {
        final json = response.jsonBody;
        return Pair(
          json["data"] == null
              ? []
              : List<Offer>.from(json["data"]!.map((x) => Offer.fromJson(x))),
          null,
        );
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
