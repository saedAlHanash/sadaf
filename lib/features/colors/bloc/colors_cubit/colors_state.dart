part of 'colors_cubit.dart';

class ColorsInitial extends AbstractCubit<List<ColorModel>> {
  final int selectedId;

  const ColorsInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.selectedId,
  });

  factory ColorsInitial.initial() {
    return const ColorsInitial(
      result: [],
      selectedId: 0,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ColorsInitial copyWith({
    CubitStatuses? statuses,
    List<ColorModel>? result,
    String? error,
    int? selectedId,
  }) {
    return ColorsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      selectedId: selectedId ?? this.selectedId,
    );
  }
}
