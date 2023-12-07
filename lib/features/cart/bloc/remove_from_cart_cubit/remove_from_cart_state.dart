part of 'remove_from_cart_cubit.dart';

class RemoveFromCartInitial extends AbstractCubit<bool> {
  final int id;

  const RemoveFromCartInitial({
    required super.result,
    super.statuses,
    super.error,
    required this.id,
  });

  factory RemoveFromCartInitial.initial() {
    return const RemoveFromCartInitial(
      result: false,
      id: 0,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  RemoveFromCartInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    int? id,
  }) {
    return RemoveFromCartInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
    );
  }
}
