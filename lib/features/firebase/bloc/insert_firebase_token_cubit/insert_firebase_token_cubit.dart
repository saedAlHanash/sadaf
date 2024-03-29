import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/enum_manager.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:sadaf/main.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/util/pair_class.dart';

part 'insert_firebase_token_state.dart';

class InsertFirebaseTokenCubit extends Cubit<InsertFirebaseTokenInitial> {
  InsertFirebaseTokenCubit() : super(InsertFirebaseTokenInitial.initial());

  

  insertFirebaseToken() async {
    if (!AppSharedPreference.isLogin) {
      Logger().e('canst send FCM user not login');
      return;
    }
    var token = await getFireToken();

    final pair = await _insertFirebaseTokenApi(token: token);

    if (pair.first == null) {
      Logger().e('error fcm to server');
    } else {
      Logger().d('done Done Fire token ');
      // emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _insertFirebaseTokenApi({
    required String token,
  }) async {
     
      final response = await APIService().postApi(
        url: PostUrl.insertFireBaseToken,
        body: {'token': token},
      );

      if (response.statusCode.success) {
        return Pair(true, null);
      } else {
      return response.getPairError;
      }
     
  }
}
