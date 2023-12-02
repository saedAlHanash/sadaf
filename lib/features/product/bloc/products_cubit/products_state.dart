part of 'products_cubit.dart';

class ProductsInitial extends AbstractCubit<List<Product>> {
  final ProductFilterRequest request;

  const ProductsInitial({
    required super.result,
    required this.request,
    super.error,
    super.statuses,
  });

  factory ProductsInitial.initial() {
    return ProductsInitial(
      result: const [],
      request: ProductFilterRequest.fromJson({}),
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ProductsInitial copyWith({
    CubitStatuses? statuses,
    List<Product>? result,
    String? error,
    ProductFilterRequest? request,
  }) {
    return ProductsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
