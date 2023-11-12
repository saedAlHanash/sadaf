import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/profile/data/request/update_profile_request.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstract_cubit_state.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileInitial> {
  UpdateProfileCubit() : super(UpdateProfileInitial.initial());

  Future<void> updateProfile() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _updateProfileApi();

    if (pair.first == null) {
      emit(state.copyWith(error: pair.second, statuses: CubitStatuses.error));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _updateProfileApi() async {
    final response = await APIService().uploadMultiPart(
      url: PostUrl.signup,
      fields: state.request.toJson(),
      files: state.request.avatar == null ? null : [state.request.avatar],
    );

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError<bool>();
    }
  }

  set setName(String? val) => state.request.name = val;

  set setHomeAddress(String? val) => state.request.homeAddress = val;

  set setCountry(String? val) => state.request.country = val;

  set setCity(String? val) => state.request.city = val;


  set setEmailOrPhone(String? val) => state.request.emailOrPhone = val;

  set setMapAddress(String? val) => state.request.mapAddress = val;

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
