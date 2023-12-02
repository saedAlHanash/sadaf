import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sadaf/core/api_manager/api_service.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../generated/l10n.dart';
import '../../data/response/coupon_response.dart';

part 'coupon_state.dart';

class CouponCubit extends Cubit<CouponInitial> {
  CouponCubit() : super(CouponInitial.initial());

  

  Future<void> checkCoupon(BuildContext context,
      {String? couponCode, num total = 0}) async {
    if (couponCode == null || couponCode.isEmpty || total == 0) return;
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _checkCouponApi(couponCode: couponCode, total: total);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<CheckCouponResult?, String?>> _checkCouponApi({
    required String couponCode,
    required num total,
  }) async {
     
      final response = await APIService().getApi(
        url: GetUrl.coupon,
        query: {
          'code': couponCode,
          'total_price': total,
        },
      );

      if (response.statusCode == 200) {
        return Pair(CheckCouponResponse.fromJson(response.jsonBody).data, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
     
  }

  void reInit() => emit(CouponInitial.initial());
}
