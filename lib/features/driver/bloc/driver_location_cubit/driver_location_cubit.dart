import 'package:bloc/bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/driver_location_response.dart';

part 'driver_location_state.dart';

class DriverLocationCubit extends Cubit<DriverLocationInitial> {
  DriverLocationCubit() : super(DriverLocationInitial.initial());

  Future<void> getDriverLocation({required int orderId}) async {

    if (state.orderId == 0) {
      emit(state.copyWith(statuses: CubitStatuses.loading, orderId: orderId));
    }

    final pair = await _getDriverLocationApi();

    if (pair.first != null) {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<Coordinate?, String?>> _getDriverLocationApi() async {
    final response = await APIService().getApi(
      url: GetUrl.driverLocation,
      path: state.orderId.toString(),
    );

    if (response.statusCode == 200) {
      return Pair(
          DriverLocationResponse.fromJson(response.jsonBody).data.coordinate, null);
    } else {
      return response.getPairError;
    }
  }
}
