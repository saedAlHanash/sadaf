part of 'signup_cubit.dart';

class SignupInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const SignupInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory SignupInitial.initial() {
    return const SignupInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  SignupInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return SignupInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
