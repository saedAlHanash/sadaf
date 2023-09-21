part of 'category_by_id_cubit.dart';

class CategoryByIdInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Product> result;
  final String error;

  const CategoryByIdInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory CategoryByIdInitial.initial() {
    return const CategoryByIdInitial(
      result: <Product>[],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CategoryByIdInitial copyWith({
    CubitStatuses? statuses,
    List<Product>? result,
    String? error,
  }) {
    return CategoryByIdInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
