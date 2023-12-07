part of 'order_by_id_cubit.dart';

class OrderByIdInitial extends AbstractCubit<Order> {
  final int id;

  const OrderByIdInitial({
    required super.result,
    required this.id,
    super.error,
    super.statuses,
  });

  factory OrderByIdInitial.initial() {
    return OrderByIdInitial(
      result: Order.fromJson({}),
      id: 0,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  OrderByIdInitial copyWith({
    CubitStatuses? statuses,
    Order? result,
    String? error,
    int? id,
  }) {
    return OrderByIdInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
    );
  }
}
