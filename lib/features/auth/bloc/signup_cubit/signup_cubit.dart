import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstract_cubit_state.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../generated/l10n.dart';
import '../../data/request/signup_request.dart';
import '../../ui/pages/forget_passowrd_page.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupInitial> {
  SignupCubit() : super(SignupInitial.initial());

  Future<void> signup() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _signupApi();

    if (pair.first == null) {
      emit(state.errorState(error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _signupApi() async {
    final response = await APIService().postApi(
      url: PostUrl.signup,
      body: state.request.toJson(),
    );

    if (response.statusCode.success) {
      await AppSharedPreference.cashPhoneOrEmail(state.request.phoneOrEmail);
      otp = response.jsonBody['data']['otp_code'].toString();
      return Pair(true, null);
    } else {
      return response.getPairError<bool>();
    }
  }

  set setName(String? name) => state.request.name = name;

  set setBirthday(DateTime? birthday) => state.request.birthday = birthday;

  set setPhoneOrEmail(String? phoneOrEmail) => state.request.phoneOrEmail = phoneOrEmail;

  set setPassword(String? password) => state.request.password = password;

  set setRePassword(String? rePassword) => state.request.rePassword = rePassword;

  String? get validateName {
    if (state.request.name == null) {
      return S().nameEmpty;
    }
    return null;
  }

  String? get validateBirthday {
    if (state.request.birthday == null) {
      return '${S().birthday} ${S().is_required}';
    }
    return null;
  }

  String? get validatePhoneOrEmail {
    if (state.request.phoneOrEmail == null) {
      return '${S().email} - ${S().phoneNumber}'
          ' ${S().is_required}';
    }
    return null;
  }

  String? get validatePassword {
    if (state.request.password == null) {
      return '${S().password} ${S().is_required}';
    }
    return null;
  }

  String? get validateRePassword {
    if (state.request.rePassword != state.request.password) {
      return S().passwordNotMatch;
    }
    return null;
  }
}
