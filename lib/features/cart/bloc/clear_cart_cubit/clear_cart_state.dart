part of 'clear_cart_cubit.dart';

class ClearCartInitial extends AbstractCubit<bool> {
  final int id;

  const ClearCartInitial({
    required super.result,
    super.statuses,
    super.error,
    required this.id,
  });

  factory ClearCartInitial.initial() {
    return const ClearCartInitial(
      result: false,
      id: 0,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ClearCartInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    int? id,
  }) {
    return ClearCartInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
    );
  }
}
