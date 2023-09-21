part of 'forget_password_cubit.dart';
class ForgetPasswordInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const ForgetPasswordInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory ForgetPasswordInitial.initial() {
    return const ForgetPasswordInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ForgetPasswordInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return ForgetPasswordInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}