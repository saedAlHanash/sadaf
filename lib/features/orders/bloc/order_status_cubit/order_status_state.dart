part of 'order_status_cubit.dart';

class OrderStatusInitial extends AbstractCubit<List<OrderStatusResult>> {
  final int id;

  const OrderStatusInitial({
    required super.result,
    required this.id,
    super.error,
    super.statuses,
  });

  factory OrderStatusInitial.initial() {
    return OrderStatusInitial(
      result: [],
      id: 0,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  OrderStatusInitial copyWith({
    CubitStatuses? statuses,
    List<OrderStatusResult>? result,
    String? error,
    int? id,
  }) {
    return OrderStatusInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
    );
  }

  DateTime? getDate(OrderStatus state) {
    for (var e in result) {
      if (state == e.status) return e.changeAt;
    }
    return null;
  }
}
