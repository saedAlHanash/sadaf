import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../generated/l10n.dart';
import '../../data/request/update_user_request.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserInitial> {
  UpdateUserCubit() : super(UpdateUserInitial.initial());
  final network = sl<NetworkInfo>();

  Future<void> update(BuildContext context, {required UpdateUserRequest request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _updateApi(request: request);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<String?, String?>> _updateApi({required UpdateUserRequest request}) async {
    if (await network.isConnected) {
      var url = '';
      var q = <String, dynamic>{};

      if (request.updateType == UpdateType.name) {
        url = PutUrl.updateName;
        q['name'] = request.name;
      } else if (request.updateType == UpdateType.phone) {
        url = PutUrl.updatePhone;
        q['phone'] = request.phone;
      } else if (request.updateType == UpdateType.address) {
        url = PutUrl.updateAddress;
        q['address'] = request.address;
        q['city'] = request.city;
        q['country'] = request.country;
      } else {
        q['old_password'] = request.oldPass;
        q['password'] = request.newPass;
        q['password_confirmation'] = request.rePass;
      }

      late Response response;

      if (request.updateType != UpdateType.pass) {
        response = await APIService().puttApi(
          url: url,
          query: q,
        );
      } else {
        response = await APIService().postApi(
          url: PostUrl.restPass,
          body: q,
        );
      }

      if (response.statusCode == 200) {
        var user = AppSharedPreference.getUserModel();

        if (request.updateType == UpdateType.name) {
          user.name = request.name;
        } else if (request.updateType == UpdateType.phone) {
          user.phone = request.phone;
        } else {
          user.address = request.address;
          user.city = request.city;
          user.country = request.country;
        }

        await AppSharedPreference.cashUser(user);

        return Pair(response.jsonBody['message'] ?? '', null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, S().noInternet);
    }
  }
}
