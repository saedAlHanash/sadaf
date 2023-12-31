part of 'flash_deal_cubit.dart';

class FlashDealsInitial extends AbstractCubit<List<FlashDeal>> {
  const FlashDealsInitial({
    required super.result,
    super.error,
    super.statuses,
  });

  factory FlashDealsInitial.initial() {
    return const FlashDealsInitial(
      result: [],
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  FlashDealsInitial copyWith({
    CubitStatuses? statuses,
    List<FlashDeal>? result,
    String? error,
  }) {
    return FlashDealsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
