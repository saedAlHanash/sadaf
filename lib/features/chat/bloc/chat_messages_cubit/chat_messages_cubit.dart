import 'package:bloc/bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/colors/data/response/color_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/message_response.dart';

part 'chat_messages_state.dart';

class MessagesCubit extends Cubit<MessagesInitial> {
  MessagesCubit() : super(MessagesInitial.initial());

  Future<void> getMessages({required int mId}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, mId: mId));

    final pair = await _getMessagesApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<MessageModel>?, String?>> _getMessagesApi() async {
    final response = await APIService().getApi(
      url: GetUrl.getMessages,
      path: state.mId.toString(),
    );

    if (response.statusCode == 200) {
      return Pair(MessageResponse.fromJson(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }

  Future<void> getRoomMessages({required int mId}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, mId: mId));

    final pair = await _getRoomMessagesApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<MessageModel>?, String?>> _getRoomMessagesApi() async {
    final response = await APIService().getApi(
      url: GetUrl.getRoomMessages,
      path: state.mId.toString(),
    );

    if (response.statusCode == 200) {
      return Pair(MessageResponse.fromJson(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }

  void addMessageLocal(MessageModel message) {
    emit(state.copyWith(result: state.result..add(message)));
  }
}
