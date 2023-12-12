part of 'governors_cubit.dart';

class GovernorsInitial extends AbstractCubit<List<GovernorModel>> {
  final int selectedId;

  const GovernorsInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.selectedId,
  });

  factory GovernorsInitial.initial() {
    return const GovernorsInitial(
      result: [],
      selectedId: 0,
    );
  }

  List<SpinnerItem> getSpinnerItem({int? selectedId}) {
    if (result.isEmpty) return [SpinnerItem(name: '-')];

    final list =  result
        .map(
          (e) => SpinnerItem(
              name: e.name, id: e.id, item: e, isSelected: e.id == selectedId),
        )
        .toList();
    return  list;
  }

  @override
  List<Object> get props => [statuses, result, error];

  GovernorsInitial copyWith({
    CubitStatuses? statuses,
    List<GovernorModel>? result,
    String? error,
    int? selectedId,
  }) {
    return GovernorsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      selectedId: selectedId ?? this.selectedId,
    );
  }
}
