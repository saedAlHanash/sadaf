part of 'orders_cubit.dart';


class OrdersInitial extends AbstractCubit<List<Order>> {

  const OrdersInitial({
    required super.result,
    super.error,
    super.statuses,
  });

  factory OrdersInitial.initial() {
    return OrdersInitial(
      result: const [],
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  OrdersInitial copyWith({
    CubitStatuses? statuses,
    List<Order>? result,
    String? error,
  }) {
    return OrdersInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
