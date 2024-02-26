import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:sadaf/features/profile/data/request/update_profile_request.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';
import '../../data/response/profile_response.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileInitial> {
  UpdateProfileCubit() : super(UpdateProfileInitial.initial());

  Future<void> updateProfile({UpdateProfileType? type}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, type: type));
    late final Pair<dynamic, dynamic> pair;
    switch (state.type) {
      case UpdateProfileType.normal:
        pair = await _updateProfileApi();
        break;

      case UpdateProfileType.confirmAddPhone:
        pair = await _confirmPhone();
        break;
    }

    if (pair.first == null) {
      emit(state.copyWith(error: pair.second, statuses: CubitStatuses.error));
      showErrorFromApi(state);
    } else {
      await _getProfileApi();
      emit(state.copyWith(
        statuses: CubitStatuses.done,
        result: pair.first is Profile ? pair.first : null,
      ));
    }
  }

  Future<Pair<Profile?, String?>> _updateProfileApi() async {
    final response = await APIService().uploadMultiPart(
      url: PostUrl.updateProfile,
      fields: state.request.toJson(),
      files: state.request.avatar == null ? null : [state.request.avatar],
    );

    if (response.statusCode.success) {
      return Pair(ProfileResponse.fromJson(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }

  Future<Pair<Profile?, String?>> _getProfileApi() async {
    final response = await APIService().getApi(
      url: GetUrl.profile,
    );

    if (response.statusCode == 200) {
      final profile = ProfileResponse.fromJson(response.jsonBody).data;
      await AppProvider.cashProfile(profile);
      return Pair(profile, null);
    } else {
      return response.getPairError;
    }
  }

  Future<Pair<bool?, String?>> _addPhone() async {
    final response = await APIService().uploadMultiPart(
      url: PostUrl.addPhone,
      fields: state.request.toJsonPhone(),
    );

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }

  Future<Pair<bool?, String?>> _confirmPhone() async {
    final response = await APIService().uploadMultiPart(
      url: PostUrl.socialVerifyPhone,
      fields: state.request.toJsonPhoneConfirm(),
    );

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }

  final addressController = TextEditingController(
    text: AppProvider.profile.address,
  );
  final locationController = TextEditingController(
    text: AppProvider.profile.mapAddress.toString(),
  );

  set setName(String? val) => state.request.name = val;

  set setHomeAddress(String? val) => state.request.address = val;

  set setGovernor(int? val) => state.request.governorId = val;

  set setReceiverPhone(String? val) => state.request.receiverPhone = val;

  set setEmailOrPhone(String? val) => state.request.emailOrPhone = val;

  set setOtpPhone(String? val) => state.request.otpCode = val;

  set setMapAddress(MapAddress? val) => state.request.mapAddress = val;

  set setAvatar(UploadFile? val) => state.request.avatar = val;

  String? get validateName {
    if (state.request.name.isBlank) {
      return S().nameEmpty;
    }
    return null;
  }

  String? get validatePhoneOrEmail {
    if (state.request.emailOrPhone.isBlank) {
      return '${S().email} - ${S().phoneNumber}'
          ' ${S().is_required}';
    }
    return null;
  }
}
