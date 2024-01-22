part of 'add_message_cubit.dart';

class AddMessageInitial extends AbstractCubit<bool> {
  final MessageRequest request;
  final int orderId;

  const AddMessageInitial({
    required super.result,
    super.statuses,
    super.error,
    required this.request,
    required this.orderId,
  });

  factory AddMessageInitial.initial() {
    return AddMessageInitial(
      result: false,
      request: MessageRequest(),
      orderId: 0,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AddMessageInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    MessageRequest? request,
    int? orderId,
  }) {
    return AddMessageInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      orderId: orderId ?? this.orderId,
    );
  }
}
