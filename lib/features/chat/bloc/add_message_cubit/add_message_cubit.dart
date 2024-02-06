import 'package:bloc/bloc.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/abstraction.dart';
import 'package:sadaf/features/chat/data/request/message_request.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'add_message_state.dart';

class AddMessageCubit extends Cubit<AddMessageInitial> {
  AddMessageCubit() : super(AddMessageInitial.initial());

  Future<void> addMessage({required int mId, required MessageRequest request}) async {
    emit(state.copyWith(
      statuses: CubitStatuses.loading,
      mId: mId,
      request: request,
    ));

    final pair = await _addMessageApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _addMessageApi() async {
    final response = await APIService().uploadMultiPart(
      url: PostUrl.addMessage(state.mId),
      fields: state.request.toMap(),
      files: state.request.file,
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }

  Future<void> addSupportMessage(
      {required MessageRequest request}) async {
    emit(state.copyWith(
      statuses: CubitStatuses.loading,
      request: request,
    ));

    final pair = await _addSupportMessageApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _addSupportMessageApi() async {
    final response = await APIService().uploadMultiPart(
      url: PostUrl.addSupportMessage,
      fields: state.request.toMap(),
      files: state.request.file,
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
