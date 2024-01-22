part of 'chat_messages_cubit.dart';

class MessagesInitial extends AbstractCubit<List<MessageModel>> {
  final int selectedId;

  const MessagesInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.selectedId,
  });

  factory MessagesInitial.initial() {
    return const MessagesInitial(
      result: [],
      selectedId: 0,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  MessagesInitial copyWith({
    CubitStatuses? statuses,
    List<MessageModel>? result,
    String? error,
    int? selectedId,
  }) {
    return MessagesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      selectedId: selectedId ?? this.selectedId,
    );
  }
}
