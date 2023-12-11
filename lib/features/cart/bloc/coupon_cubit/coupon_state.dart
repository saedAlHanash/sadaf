part of 'coupon_cubit.dart';

class CouponInitial extends AbstractCubit<bool> {
  final String coupon;
  const CouponInitial({
    required super.result,
    super.statuses,
    super.error,
    required this.coupon,
  });

  factory CouponInitial.initial() {
    return const CouponInitial(
      result: false,
      coupon: '',
    );
  }

  @override
  List<Object> get props => [statuses, result, error,coupon];

  CouponInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    String? coupon,
  }) {
    return CouponInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      coupon: coupon ?? this.coupon,
    );
  }
}
