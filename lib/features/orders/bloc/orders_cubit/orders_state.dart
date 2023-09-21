part of 'orders_cubit.dart';

class OrdersInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Order> result;
  final String error;

  const OrdersInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory OrdersInitial.initial() {
    return const OrdersInitial(
      result: <Order>[],
      error: '',
      statuses: CubitStatuses.init,
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
