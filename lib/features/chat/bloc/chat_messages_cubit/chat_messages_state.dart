part of 'chat_messages_cubit.dart';

class MessagesInitial extends AbstractCubit<List<MessageModel>> {
  final int mId;

  const MessagesInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.mId,
  });

  factory MessagesInitial.initial() {
    return const MessagesInitial(
      result: [],
      mId: 0,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  MessagesInitial copyWith({
    CubitStatuses? statuses,
    List<MessageModel>? result,
    String? error,
    int? mId,
  }) {
    return MessagesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      mId: mId ?? this.mId,
    );
  }
}
