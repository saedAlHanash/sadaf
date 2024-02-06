import 'package:bloc/bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/notifications_response.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsInitial> {
  NotificationsCubit() : super(NotificationsInitial.initial());

  Future<void> getNotifications() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _getNotificationsApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<NotificationModel>?, String?>> _getNotificationsApi() async {
    final response = await APIService().getApi(
      url: GetUrl.getAllNotifications,
    );

    if (response.statusCode == 200) {
      return Pair(NotificationsResponse.fromJson(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }
}
