part of 'create_order_cubit.dart';

class CreateOrderInitial extends AbstractCubit<bool> {
  final int id;

  const CreateOrderInitial({
    required super.result,
    super.statuses,
    super.error,
    required this.id,
  });

  factory CreateOrderInitial.initial() {
    return const CreateOrderInitial(
      result: false,
      id: 0,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateOrderInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    int? id,
  }) {
    return CreateOrderInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
    );
  }
}
