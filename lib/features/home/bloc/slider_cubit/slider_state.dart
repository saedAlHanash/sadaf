part of 'slider_cubit.dart';

class SliderInitial extends AbstractCubit<List<BannerModel>> {
  const SliderInitial({
    required super.result,
    super.error,
    super.statuses,
  });

  factory SliderInitial.initial() {
    return const SliderInitial(
      result: [],
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  SliderInitial copyWith({
    CubitStatuses? statuses,
    List<BannerModel>? result,
    String? error,
  }) {
    return SliderInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
