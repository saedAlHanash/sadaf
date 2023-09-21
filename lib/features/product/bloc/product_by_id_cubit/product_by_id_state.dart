part of 'product_by_id_cubit.dart';

class ProductByIdInitial extends Equatable {
  final CubitStatuses statuses;
  final ProductByIdResult result;
  final String error;

  const ProductByIdInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory ProductByIdInitial.initial() {
    return ProductByIdInitial(
      result: ProductByIdResult.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ProductByIdInitial copyWith({
    CubitStatuses? statuses,
    ProductByIdResult? result,
    String? error,
  }) {
    return ProductByIdInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}