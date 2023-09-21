part of 'reset_password_cubit.dart';

class ResetPasswordInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const ResetPasswordInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory ResetPasswordInitial.initial() {
    return const ResetPasswordInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ResetPasswordInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return ResetPasswordInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
