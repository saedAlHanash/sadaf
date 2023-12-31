import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.initial});

  final LatLng initial;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String? name;
  double? longitude;
  double? latitude;
  final _controller = Completer<GoogleMapController>();
  final Set<Marker> markers = {};
  LatLng? selectPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.initial,
          zoom: 14.4746,
        ),
        markers: markers,
        mapType: MapType.normal,
        myLocationEnabled: false,
        compassEnabled: true,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: (LatLng position) {
          // _updateMarkerPosition(position);
          latitude = position.latitude;
          longitude = position.longitude;
        },
      ),
    );
  }
}
