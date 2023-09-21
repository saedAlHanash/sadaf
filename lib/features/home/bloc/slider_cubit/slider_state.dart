part of 'slider_cubit.dart';

class SliderInitial extends Equatable {
  final CubitStatuses statuses;
  final List<SliderResult> result;
  final String error;

  const SliderInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory SliderInitial.initial() {
    return const SliderInitial(
      result: <SliderResult>[],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  SliderInitial copyWith({
    CubitStatuses? statuses,
    List<SliderResult>? result,
    String? error,
  }) {
    return SliderInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
