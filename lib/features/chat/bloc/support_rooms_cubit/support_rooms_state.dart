part of 'support_rooms_cubit.dart';

class SupportMessagesInitial extends AbstractCubit<List<Room>> {
  final int selectedId;

  const SupportMessagesInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.selectedId,
  });

  factory SupportMessagesInitial.initial() {
    return const SupportMessagesInitial(
      result: [],
      selectedId: 0,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  SupportMessagesInitial copyWith({
    CubitStatuses? statuses,
    List<Room>? result,
    String? error,
    int? selectedId,
  }) {
    return SupportMessagesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      selectedId: selectedId ?? this.selectedId,
    );
  }
}
