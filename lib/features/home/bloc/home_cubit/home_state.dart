part of 'home_cubit.dart';

class HomeInitial extends Equatable {
  final CubitStatuses statuses;
  final HomeResult result;
  final String error;

  const HomeInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory HomeInitial.initial() {
    return HomeInitial(
      result: HomeResult.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  HomeInitial copyWith({
    CubitStatuses? statuses,
    HomeResult? result,
    String? error,
  }) {
    return HomeInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
