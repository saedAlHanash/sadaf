part of 'get_me_cubit.dart';

class GetMeInitial extends Equatable {
  final CubitStatuses statuses;
  final ConfirmCodeData result;
  final String error;

  const GetMeInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory GetMeInitial.initial() {
    return  GetMeInitial(
      result: ConfirmCodeData.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  GetMeInitial copyWith({
    CubitStatuses? statuses,
    ConfirmCodeData? result,
    String? error,
  }) {
    return GetMeInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}