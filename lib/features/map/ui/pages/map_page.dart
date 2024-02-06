import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/widgets/my_button.dart';

import '../../../../generated/l10n.dart';

const initialLocation = LatLng(33.305661, 44.359682);

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.initial});

  final LatLng initial;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String? name;
  LatLng? position;

  final _controller = Completer<GoogleMapController>();
  final Set<Marker> markers = {};
  LatLng? selectPosition;

  @override
  void initState() {
    if (widget.initial.hashCode != initialLocation.hashCode) {
      markers.add(Marker(markerId: const MarkerId('1'), position: widget.initial));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: widget.initial,
                zoom: widget.initial.hashCode == initialLocation.hashCode ? 11.0 : 14.0,
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
                setState(() => this.position = position);
                markers.add(Marker(markerId: const MarkerId('1'), position: position));
              },
            ),
          ),
          Positioned(
            top: 40.0.r,
            left: 20.0.r,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const ImageMultiType(
                  url: Icons.arrow_back_ios_sharp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(20.0).r,
              child: MyButton(
                text: S.of(context).done,
                enable: position != null,
                onTap: () => Navigator.pop(context, position),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
