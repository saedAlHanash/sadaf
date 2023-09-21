part of 'add_favorite_cubit.dart';

class AddFavoriteInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;
  final bool isFav;
  final Product product;

  const AddFavoriteInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.isFav,
    required this.product,
  });

  factory AddFavoriteInitial.initial() {
    return  AddFavoriteInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
      isFav: false,
      product: Product.fromJson({}),
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AddFavoriteInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    bool? isFav,
    Product? product,
  }) {
    return AddFavoriteInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      isFav: isFav ?? this.isFav,
      product: product ?? this.product,
    );
  }
}
