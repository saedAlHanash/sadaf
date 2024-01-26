part of 'faq_cubit.dart';

class FaqInitial extends AbstractCubit<List<Faq>> {
  final int selectedId;

  const FaqInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.selectedId,
  });

  factory FaqInitial.initial() {
    return const FaqInitial(
      result: [],
      selectedId: 0,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  FaqInitial copyWith({
    CubitStatuses? statuses,
    List<Faq>? result,
    String? error,
    int? selectedId,
  }) {
    return FaqInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      selectedId: selectedId ?? this.selectedId,
    );
  }
}
