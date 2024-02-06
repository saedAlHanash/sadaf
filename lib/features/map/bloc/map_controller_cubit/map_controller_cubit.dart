import 'dart:convert';
import 'dart:math' as math;
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/map/ui/pages/map_page.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/my_marker.dart';
import '../../data/response/osrm_model.dart';
import '../../ui/widget/path_lenght_widget.dart';

part 'map_controller_state.dart';

const singleMarkerKey = -5622;

class MapControllerCubit extends Cubit<MapControllerInitial> {
  MapControllerCubit() : super(MapControllerInitial.initial());

  var mapHeight = 640.0;
  var mapWidth = 360.0;

  void setGoogleMap(GoogleMapController controller) => state.controller = controller;

  GoogleMapController? get controller => state.controller;

  Future<LatLng?> get getCenter async {
    if (controller == null) return null;

    LatLngBounds bounds = await controller!.getVisibleRegion();

    LatLng center = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );

    return center;
  }

  void test() {}

  void addMarker({required MyMarker marker}) {
    state.markers[marker.key ?? marker.point.hashCode] = marker;
    emit(state.copyWith(markerNotifier: state.markerNotifier + 1));
  }

  void addSingleMarker({required MyMarker? marker, bool? moveTo}) {
    if (marker == null) {
      state.markers.remove(singleMarkerKey);
    } else {
      state.markers[singleMarkerKey] = marker;
      if (moveTo ?? true) movingCamera(point: marker.point);
    }

    emit(state.copyWith(markerNotifier: state.markerNotifier + 1));
  }

  void movingCamera({required LatLng point, double? zoom}) {
    emit(state.copyWith(
      point: point,
      zoom: zoom,
    ));
  }

  void addMarkers({
    required List<MyMarker> marker,
    bool update = true,
    bool centerZoom = false,
  }) {
    for (var e in marker) {
      state.markers[e.key ?? e.point.hashCode] = e;
    }
    if (centerZoom) {
      centerPointMarkers();
    } else {
      state.centerZoomPoints.clear();
    }
    if (update) emit(state.copyWith(markerNotifier: state.markerNotifier + 1));
  }

  void clearMap(bool update) {
    state.markers.removeWhere((key, value) => key != singleMarkerKey);
    state.polyLines.clear();
    if (update) {
      emit(state.copyWith(
        markerNotifier: state.markerNotifier + 1,
        polylineNotifier: state.polylineNotifier + 1,
      ));
    }
  }

  void centerPointMarkers() {
    if (state.markers.length == 1) return;
    state.centerZoomPoints.clear();

    for (var e in state.markers.values) {
      state.centerZoomPoints.add(e.point);
    }
  }

  void removeMarker({LatLng? point, int? key}) {
    if (point == null && key == null) return;

    state.markers.remove(key ?? point.hashCode);

    emit(state.copyWith(markerNotifier: state.markerNotifier + 1));
  }

  void removeMarkers({List<LatLng>? points, List<int>? keys}) {
    if (points == null && keys == null) return;

    if (points != null) {
      for (var e in points) {
        state.markers.remove(e.hashCode);
      }
    } else {
      for (var e in keys!) {
        state.markers.remove(e);
      }
    }

    emit(state.copyWith(markerNotifier: state.markerNotifier + 1));
  }

  void update() {
    emit(state.copyWith(
      markerNotifier: state.markerNotifier + 1,
      polylineNotifier: state.polylineNotifier + 1,
    ));
  }

  Future<void> addPolyLine({
    required LatLng? start,
    required LatLng? end,
    required bool? addPathLength,
    int? key,
  }) async {
    if (start == null ||end == null || start.latitude == 0 || end.latitude == 0) return;

    final pair = await getRoutePointApi(start: start, end: end);

    if (pair.first != null) {
      var list = decodePolyline(pair.first!.routes.first.geometry).unpackPolyline();
      if ((addPathLength ?? false) && list.length > 2) {
        addMarker(
          marker: MyMarker(
            point: list[list.length ~/ 2],
            costumeMarker: PathLengthWidget(
              text: '${(calculateDistance(list) / 1000).toStringAsFixed(1)} km',
            ),
            markerSize: Size(70.0.r, 70.0.r),
          ),
        );
      }
      state.polyLines[key ?? end.hashCode] = Pair(list, Colors.black);
      emit(state.copyWith(polylineNotifier: state.polylineNotifier + 1));
    }
  }

  void addEncodedPolyLine({
    required MyPolyLine myPolyLine,
    bool update = true,
    required bool? addPathLength,
  }) {
    var list = decodePolyline(myPolyLine.encodedPolyLine).unpackPolyline();
    if ((addPathLength ?? false) && list.length > 2) {
      addMarker(
        marker: MyMarker(
          point: list[list.length ~/ 2],
          costumeMarker: PathLengthWidget(
            text: '${(calculateDistance(list) / 1000).toStringAsFixed(1)} كم',
          ),
          markerSize: Size(70.0.r, 70.0.r),
        ),
      );
    }
    myPolyLine.endPoint = list.lastOrNull;

    state.polyLines[myPolyLine.key ?? myPolyLine.endPoint.hashCode] =
        Pair(list, myPolyLine.color ?? Colors.black);

    if (update) {
      emit(state.copyWith(polylineNotifier: state.polylineNotifier + 1));
    }
  }


  Future<Pair<OsrmModel?, String?>> getRoutePointApi(
      {required LatLng start, required LatLng end}) async {
    final response = await APIService().getApi(
        url: 'route/v1/driving',
        hostName: 'router.project-osrm.org',
        path: '${start.longitude},${start.latitude};'
            '${end.longitude},${end.latitude}');

    if (response.statusCode == 200) {
      return Pair(OsrmModel.fromJson(jsonDecode(response.body)), null);
    } else {
      return Pair(null, 'error');
    }
  }

  void removePolyLine({LatLng? endPoint, int? key}) {
    if (endPoint == null && key == null) return;
    state.polyLines.remove(key ?? endPoint.hashCode);
    emit(state.copyWith(polylineNotifier: state.polylineNotifier + 1));
  }

  void updateMarkersWithZoom(double zoom) {
    emit(state.copyWith(markerNotifier: state.markerNotifier + 1, mapZoom: zoom));
  }
}

double distanceBetween(LatLng point1, LatLng point2) {
  const p = 0.017453292519943295;
  final a = 0.5 -
      cos((point2.latitude - point1.latitude) * p) / 2 +
      cos(point1.latitude * p) *
          cos(point2.latitude * p) *
          (1 - cos((point2.longitude - point1.longitude) * p)) /
          2;
  return 12742 * asin(sqrt(a));
}

double getZoomLevel(LatLng point1, LatLng point2, double width) {
  if (point1.hashCode == point2.hashCode) {
    return 13.0;
  }
  final distance = distanceBetween(point1, point2) * 1000;
  final zoomScale = distance / (width * 0.6);
  final zoom =
      log(40075016.686 * cos(point1.latitude * pi / 180) / (256 * zoomScale)) / log(2);

  return zoom;
}

double calculateDistance(List<LatLng> points) {
  const double earthRadius = 6371000; // in meters
  double totalDistance = 0;

  for (int i = 0; i < points.length - 1; i++) {
    final p1 = points[i];
    final p2 = points[i + 1];

    final lat1 = p1.latitude * pi / 180;
    final lat2 = p2.latitude * pi / 180;
    final lon1 = p1.longitude * pi / 180;
    final lon2 = p2.longitude * pi / 180;

    final dLat = lat2 - lat1;
    final dLon = lon2 - lon1;

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final distance = earthRadius * c;
    totalDistance += distance;
  }

  return totalDistance;
}

LatLngBounds calculateLatLngBounds(List<LatLng> latLngList) {
  double minLat = 90.0;
  double maxLat = -90.0;
  double minLng = 180.0;
  double maxLng = -180.0;

  for (LatLng latLng in latLngList) {
    minLat = math.min(minLat, latLng.latitude);
    maxLat = math.max(maxLat, latLng.latitude);
    minLng = math.min(minLng, latLng.longitude);
    maxLng = math.max(maxLng, latLng.longitude);
  }

  LatLng southwest = LatLng(minLat, minLng);
  LatLng northeast = LatLng(maxLat, maxLng);

  return LatLngBounds(southwest: southwest, northeast: northeast);
}
