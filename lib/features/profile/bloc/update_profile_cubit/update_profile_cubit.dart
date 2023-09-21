import 'dart:async';
import 'dart:convert';

import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/profile/data/request/update_profile_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../auth/data/response/login_response.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileInitial> {
  UpdateProfileCubit() : super(UpdateProfileInitial.initial());
  final network = sl<NetworkInfo>();

  Future<void> updateProfile(
    BuildContext context, {
    required UpdateProfileRequest request,
  }) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _updateProfileApi(request: request);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      // AppSharedPreference.cashConfirmCodeData(pair.first);
      emit(state.copyWith(statuses: CubitStatuses.done, result: true));
    }
  }

  Future<Pair<ConfirmCodeData?, String?>> _updateProfileApi(
      {required UpdateProfileRequest request}) async {
    if (await network.isConnected) {
      int? id;
      if (request.path != null && request.path!.isNotEmpty) {
        final responseFile = await _uploadFile(path: request.path);
        if (responseFile.first == null) {
          return Pair(null, responseFile.second);
        }
        id = responseFile.first;
      }

      request.photoID = id;
      final response = await APIService().puttApi(
        url: GetUrl.getMe,
        body: request.toMap(),
      );

      if (response.statusCode.success) {
        return Pair(ConfirmCodeData.fromJson(jsonDecode(response.body)), null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }

  Future<Pair<int?, String?>> _uploadFile({required String? path}) async {
    if (await network.isConnected) {
      final response = await APIService().uploadMultiPart(
        url: PostUrl.uploadFile,
        nameKey: 'medium',
        files: [path ?? ''],

      );

      if (response.statusCode.success) {
        return Pair(jsonDecode(response.body)['id'] ?? 0, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }

  void setImage(String? path) {
    if (path == null) return;

    Timer(const Duration(seconds: 1), () {
      emit(state.copyWith(image: 'file$path'));
    });
  }
}
