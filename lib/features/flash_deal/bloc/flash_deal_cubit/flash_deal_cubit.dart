import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/flash_deal.dart';

part 'flash_deal_state.dart';

class FlashDealsCubit extends Cubit<FlashDealsInitial> {
  FlashDealsCubit() : super(FlashDealsInitial.initial());

  

  Future<void> getFlashDeals(BuildContext context) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getFlashDealsApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<FlashDeal>?, String?>> _getFlashDealsApi() async {
     
      final response = await APIService().getApi(
        url: GetUrl.flashDeals,
      );

      if (response.statusCode == 200) {
        final json = response.jsonBody;
        return Pair(
          json["data"] == null
              ? []
              : List<FlashDeal>.from(json["data"]!.map((x) => FlashDeal.fromJson(x))),
          null,
        );
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
     
  }
}
