part of 'resend_code_cubit.dart';

class ResendCodeInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const ResendCodeInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory ResendCodeInitial.initial() {
    return const ResendCodeInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ResendCodeInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return ResendCodeInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}