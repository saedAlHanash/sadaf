part of 'new_arrival_cubit.dart';

class NewArrivalProductsInitial extends AbstractCubit<List<Product>> {

  const NewArrivalProductsInitial({
    required super.result,
    super.error,
    super.statuses,
  });

  factory NewArrivalProductsInitial.initial() {
    return NewArrivalProductsInitial(
      result: const [],
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  NewArrivalProductsInitial copyWith({
    CubitStatuses? statuses,
    List<Product>? result,
    String? error,
  }) {
    return NewArrivalProductsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
