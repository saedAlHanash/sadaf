part of 'insert_firebase_token_cubit.dart';

class InsertFirebaseTokenInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const InsertFirebaseTokenInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory InsertFirebaseTokenInitial.initial() {
    return const InsertFirebaseTokenInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  InsertFirebaseTokenInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return InsertFirebaseTokenInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
