part of 'get_favorite_cubit.dart';

class FavoriteInitial extends AbstractCubit<List<Fav>> {
  const FavoriteInitial({
    required super.result,
    super.error,
    super.statuses,
  });

  factory FavoriteInitial.initial() {
    return const FavoriteInitial(
      result: [],
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  FavoriteInitial copyWith({
    CubitStatuses? statuses,
    List<Fav>? result,
    String? error,
  }) {
    return FavoriteInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
