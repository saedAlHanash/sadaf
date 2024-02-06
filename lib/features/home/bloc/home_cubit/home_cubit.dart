import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/home/data/response/home_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/snack_bar_message.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeInitial> {
  HomeCubit() : super(HomeInitial.initial());

  

  Future<void> getHome(BuildContext context) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getHomeApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<HomeResult?, String?>> _getHomeApi() async {
     
      final response = await APIService().getApi(
        url: GetUrl.getHome,
      );

      if (response.statusCode == 200) {
        return Pair(HomeResponse.fromJson(response.jsonBody).data, null);
      } else {
      return response.getPairError;
      }
     
  }
}
