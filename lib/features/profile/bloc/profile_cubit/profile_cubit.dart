import 'package:bloc/bloc.dart';
import 'package:sadaf/core/app/app_provider.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/abstraction.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:sadaf/features/profile/data/response/profile_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileInitial> {
  ProfileCubit() : super(ProfileInitial.initial());

  Future<void> getProfile() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getProfileApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await AppSharedPreference.setProfile(pair.first!);
      AppProvider.reInitial();
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<Profile?, String?>> _getProfileApi() async {
    final response = await APIService().getApi(
      url: GetUrl.profile,
    );

    if (response.statusCode == 200) {
      return Pair(ProfileResponse.fromJson(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }
}
