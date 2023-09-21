part of 'offers_cubit.dart';

class OffersInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Offer> result;
  final String error;

  const OffersInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory OffersInitial.initial() {
    return const OffersInitial(
      result: <Offer>[],
      error: '',
      statuses: CubitStatuses.init,
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