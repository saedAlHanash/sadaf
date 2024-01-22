import 'package:bloc/bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/support_message_response.dart';

part 'support_rooms_state.dart';

class SupportMessagesCubit extends Cubit<SupportMessagesInitial> {
  SupportMessagesCubit() : super(SupportMessagesInitial.initial());

  Future<void> getSupportMessages() async {
    emit(state.copyWith(statuses: CubitStatuses.loading ));

    final pair = await _getSupportMessagesApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Room>?, String?>> _getSupportMessagesApi() async {
    final response = await APIService().getApi(
      url: GetUrl.getSupportMessages,
    );

    if (response.statusCode == 200) {
      return Pair(SupportMessageResponse.fromJson(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }


}
