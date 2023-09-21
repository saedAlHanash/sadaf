part of 'get_favorite_cubit.dart';

class FavoriteInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Product> result;
  final List<int> favIds;
  final String error;

  const FavoriteInitial({
    required this.statuses,
    required this.result,
    required this.favIds,
    required this.error,
  });

  factory FavoriteInitial.initial() {
    return const FavoriteInitial(
      result: [],
      favIds: <int>[],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  FavoriteInitial copyWith({
    CubitStatuses? statuses,
    List<Product>? result,
    List<int>? favIds,
    String? error,
  }) {
    return FavoriteInitial(
      statuses: statuses ?? this.statuses,
      favIds: favIds ?? this.favIds,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
