part of 'product_by_id_cubit.dart';

class ProductByIdInitial extends AbstractCubit<Product> {
  final int id;

  const ProductByIdInitial({
    required super.result,
    required this.id,
    super.error,
    super.statuses,
  });

  factory ProductByIdInitial.initial() {
    return ProductByIdInitial(
      result: Product.fromJson({}),
      id: 0,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ProductByIdInitial copyWith({
    CubitStatuses? statuses,
    Product? result,
    String? error,
    int? id,
  }) {
    return ProductByIdInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
    );
  }
}
