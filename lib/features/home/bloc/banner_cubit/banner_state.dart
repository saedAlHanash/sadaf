part of 'banner_cubit.dart';

class BannerInitial extends AbstractCubit<List<BannerModel>> {
  const BannerInitial({
    required super.result,
    super.error,
    super.statuses,
  });

  factory BannerInitial.initial() {
    return const BannerInitial(
      result: [],
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  BannerInitial copyWith({
    CubitStatuses? statuses,
    List<BannerModel>? result,
    String? error,
  }) {
    return BannerInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
