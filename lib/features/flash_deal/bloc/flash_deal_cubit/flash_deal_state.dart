part of 'flash_deal_cubit.dart';

class FlashDealsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<FlashDeal> result;
  final String error;

  const FlashDealsInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory FlashDealsInitial.initial() {
    return const FlashDealsInitial(
      result: <FlashDeal>[],
      error: '',
      statuses: CubitStatuses.init,
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