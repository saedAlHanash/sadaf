part of 'offers_cubit.dart';

class OffersInitial extends AbstractCubit<List<Offer>> {
  const OffersInitial({
    required super.result,
    super.error,
    super.statuses,
  });

  factory OffersInitial.initial() {
    return const OffersInitial(
      result: [],
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  OffersInitial copyWith({
    CubitStatuses? statuses,
    List<Offer>? result,
    String? error,
  }) {
    return OffersInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
