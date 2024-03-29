import 'package:bloc/bloc.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/shared_preferences.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';

part 'resend_code_state.dart';

class ResendCodeCubit extends Cubit<ResendCodeInitial> {
  ResendCodeCubit() : super(ResendCodeInitial.initial());

  Future<void> resendCode({String? phone}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _resendCodeApi(phone: phone);

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<String?, String?>> _resendCodeApi({String? phone}) async {
    final response = await APIService().postApi(
      url: PostUrl.resendCode,
      query: {'email_or_phone': phone ?? AppSharedPreference.getPhoneOrEmail},
    );

    if (response.statusCode == 403) {
      AppSharedPreference.removePhoneOrEmail();
    }
    if (response.statusCode.success) {
      return Pair(response.jsonBody['data']['otp_code'].toString(), null);
    } else {
      return response.getPairError;
    }
  }
}
