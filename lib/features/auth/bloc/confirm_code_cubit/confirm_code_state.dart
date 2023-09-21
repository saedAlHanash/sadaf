part of 'confirm_code_cubit.dart';

class ConfirmCodeInitial extends Equatable {
  final CubitStatuses statuses;
  final ConfirmCodeData result;
  final String error;

  const ConfirmCodeInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory ConfirmCodeInitial.initial() {
    return ConfirmCodeInitial(
      result: ConfirmCodeData.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ConfirmCodeInitial copyWith({
    CubitStatuses? statuses,
    ConfirmCodeData? result,
    String? error,
  }) {
    return ConfirmCodeInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}