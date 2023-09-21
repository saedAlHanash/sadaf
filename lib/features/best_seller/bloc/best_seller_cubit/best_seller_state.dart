part of 'best_seller_cubit.dart';

class BestSellersInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Product> result;
  final String error;

  const BestSellersInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory BestSellersInitial.initial() {
    return const BestSellersInitial(
      result: <Product>[],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  BestSellersInitial copyWith({
    CubitStatuses? statuses,
    List<Product>? result,
    String? error,
  }) {
    return BestSellersInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}