part of 'search_cubit.dart';

class SearchInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Product> result;
  final String error;

  const SearchInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory SearchInitial.initial() {
    return const SearchInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  SearchInitial copyWith({
    CubitStatuses? statuses,
    List<Product>? result,
    String? error,
  }) {
    return SearchInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
