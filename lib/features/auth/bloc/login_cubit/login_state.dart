part of 'login_cubit.dart';

class LoginInitial extends AbstractCubit<LoginData> {
  final LoginRequest request;

  const LoginInitial({
    required super.result,
    super.error,
    required this.request,
    super.statuses,
  });

  factory LoginInitial.initial() {
    return LoginInitial(
      result: LoginData.fromJson({}),
      error: '',
      request: LoginRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  LoginInitial copyWith({
    CubitStatuses? statuses,
    LoginData? result,
    String? error,
    LoginRequest? request,
  }) {
    return LoginInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
