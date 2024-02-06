part of 'categories_cubit.dart';

class CategoriesInitial extends AbstractCubit<List<Category>> {
  final int selectedId;
  final int subId;

  const CategoriesInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.selectedId,
    required this.subId,
  });

  factory CategoriesInitial.initial() {
    return const CategoriesInitial(
      result: [],
      selectedId: 0,
      subId: 0,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  List<SpinnerItem> getSpinnerItem({int? selectedId}) {
    if (result.isEmpty) return [SpinnerItem(name: '-')];

    final list = result
        .map(
          (e) => SpinnerItem(
              name: e.name, id: e.id, item: e, isSelected: e.id == selectedId),
        )
        .toList()
      ..insert(
        0,
        SpinnerItem(
          name: S().categories,
          id: -1,
        ),
      );
    return list;
  }

  CategoriesInitial copyWith({
    CubitStatuses? statuses,
    List<Category>? result,
    String? error,
    int? selectedId,
    int? subId,
  }) {
    return CategoriesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      selectedId: selectedId ?? this.selectedId,
      subId: subId ?? this.subId,
    );
  }
}
