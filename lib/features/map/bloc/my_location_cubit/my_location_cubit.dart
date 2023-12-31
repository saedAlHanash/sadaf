import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../data/response/osm_name_model.dart';

part 'my_location_state.dart';

class MyLocationCubit extends Cubit<MyLocationInitial> {
  MyLocationCubit() : super(MyLocationInitial.initial());

  void showErrorSnackBar({required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  Future<void> getMyLocation(
    BuildContext context, {
    bool? latestLocation,
    bool? moveMap,
  }) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      if (context.mounted) {
        showErrorSnackBar(message: 'Location services are disabled.', context: context);
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        if (context.mounted) {
          showErrorSnackBar(message: 'Location permissions are denied', context: context);
        }
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      if (context.mounted) {
        showErrorSnackBar(
            message: 'Location permissions are permanently denied, '
                'we cannot request permissions.',
            context: context);
      }
    }

    emit(state.copyWith(state: CubitStatuses.loading, moveMap: moveMap));

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final pos = (latestLocation ?? false)
        ? await Geolocator.getLastKnownPosition()
        : await Geolocator.getCurrentPosition();

    if (pos != null) {
      final latLng = LatLng(pos.latitude, pos.longitude);

      final name = await getLocationNameApi(latLng: latLng);

      emit(state.copyWith(result: latLng, state: CubitStatuses.done, name: name));
    }
  }
}

Future<String> getLocationNameApi({
  required LatLng latLng,
}) async {
  final response = await APIService().getApi(
    url: OsrmUrl.getLocationName,
    hostName: OsrmUrl.hostOsmName,
    query: {
      'lat': '${latLng.latitude}',
      'lon': '${latLng.longitude}',
      'format': 'json',
    },
  );

  if (response.statusCode == 200) {
    final result = OsmNameModel.fromJson(jsonDecode(response.body));

    var s = result.address.getName();
    if (s.isEmpty) s = result.displayName.removeDuplicates;
    return s;
  } else {
    return 'Error Map Server  code: ${response.statusCode}';
  }
}

class OsrmUrl {
  static const getRoutePoints = 'route/v1/driving';
  static const getLocationName = 'reverse';
  static const hostName = 'router.project-osrm.org';
  static const hostOsmName = 'nominatim.openstreetmap.org';
  static const key = '5b3ce3597851110001cf6248989ba286fa3c483496378107c01120f3';

  static const search = 'search.php';
}
