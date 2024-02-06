import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/add_review_request.dart';

part 'add_review_state.dart';

class AddReviewCubit extends Cubit<AddReviewInitial> {
  AddReviewCubit() : super(AddReviewInitial.initial());

  Future<void> addReview({required AddReviewRequest request}) async {
    if (request.reviews.isEmpty) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));

    final pair = await _bookedAppointmentsApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _bookedAppointmentsApi() async {
    final response = await APIService().postApi(
      url: PostUrl.addReview,
      body: state.request.toJson(),
      path: state.request.orderId.toString(),
    );

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
