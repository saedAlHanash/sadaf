part of 'add_review_cubit.dart';

class AddReviewInitial extends AbstractCubit<bool> {
  final AddReviewRequest request;

  // final bool addReviewParam;

  const AddReviewInitial({
    required super.result,
    super.error,
    required this.request,
    // required this.addReviewParam,
    super.statuses,
  });

  factory AddReviewInitial.initial() {
    return AddReviewInitial(
      result: false,
      error: '',
      // addReviewParam: false,
      request: AddReviewRequest.fromJson({}),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AddReviewInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    AddReviewRequest? request,
    // bool? addReviewParam,
  }) {
    return AddReviewInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      // addReviewParam: addReviewParam ?? this.addReviewParam,
    );
  }
}
