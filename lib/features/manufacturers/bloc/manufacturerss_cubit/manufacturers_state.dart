part of 'manufacturers_cubit.dart';

class ManufacturersInitial extends AbstractCubit<List<Manufacturer>> {
  final int selectedId;

  const ManufacturersInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.selectedId,
  });

  factory ManufacturersInitial.initial() {
    return const ManufacturersInitial(
      result: [],
      selectedId: 0,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ManufacturersInitial copyWith({
    CubitStatuses? statuses,
    List<Manufacturer>? result,
    String? error,
    int? selectedId,
  }) {
    return ManufacturersInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      selectedId: selectedId ?? this.selectedId,
    );
  }
}
