part of 'coupon_cubit.dart';

class CouponInitial extends Equatable {
  final CubitStatuses statuses;
  final CheckCouponResult result;
  final String error;

  const CouponInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory CouponInitial.initial() {
    return CouponInitial(
      result: CheckCouponResult.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CouponInitial copyWith({
    CubitStatuses? statuses,
    CheckCouponResult? result,
    String? error,
  }) {
    return CouponInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}