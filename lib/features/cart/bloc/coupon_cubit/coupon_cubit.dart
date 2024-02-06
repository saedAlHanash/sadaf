import 'package:bloc/bloc.dart';
import 'package:sadaf/core/api_manager/api_service.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/abstraction.dart';

import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'coupon_state.dart';

class CouponCubit extends Cubit<CouponInitial> {
  CouponCubit() : super(CouponInitial.initial());

  Future<void> applyCoupon({required String couponCode}) async {
    if (couponCode.isEmpty) return;
    emit(state.copyWith(
      statuses: CubitStatuses.loading,
      coupon: couponCode,
    ));

    final pair = await _checkCouponApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _checkCouponApi() async {
    final response = await APIService().postApi(
      url: GetUrl.coupon,
      body: {
        'coupon_code': state.coupon,
      },
    );
    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }

}
