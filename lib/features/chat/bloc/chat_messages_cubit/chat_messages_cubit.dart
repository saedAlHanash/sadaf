import 'package:bloc/bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/colors/data/response/color_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/message_item.dart';

part 'chat_messages_state.dart';

class MessagesCubit extends Cubit<MessagesInitial> {
  MessagesCubit() : super(MessagesInitial.initial());

  Future<void> getMessages({required int id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, selectedId: id));

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
      path: state.selectedId.toString(),
    );

    if (response.statusCode == 200) {
      return Pair([], null);
    } else {
      return response.getPairError;
    }
  }
}
