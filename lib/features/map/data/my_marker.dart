import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

Future<Uint8List> getBytesFromAsset(String path, num width) async {
  final data = await rootBundle.load(path);
  final codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width.toInt());
  final fi = await codec.getNextFrame();

  final bytes =
      (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List() ??
          Uint8List(0);
  return bytes;
}

Future<Uint8List> getBytesFromCanvas(int width, int height) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final Paint paint = Paint()..color = Colors.blue;
  const radius = Radius.circular(20.0);
  canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0.0, 0.0, width.toDouble(), height.toDouble()),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      paint);
  TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
  painter.text = const TextSpan(
    text: 'Hello world',
    style: TextStyle(fontSize: 25.0, color: Colors.white),
  );
  painter.layout();
  painter.paint(canvas,
      Offset((width * 0.5) - painter.width * 0.5, (height * 0.5) - painter.height * 0.5));
  final img = await pictureRecorder.endRecording().toImage(width, height);
  final data = await img.toByteData(format: ui.ImageByteFormat.png);
  return data?.buffer.asUint8List() ?? Uint8List(0);
}

class MyMarker {
  LatLng point;
  num? key;
  double? bearing;
  dynamic item;
  Size? markerSize;
  Widget costumeMarker;
  Function(dynamic item)? onTapMarker1;

  ///Number of users pickup
  String nou;

  MyMarker({
    required this.point,
    this.key,
    this.bearing,
    this.item,
    this.markerSize,
    this.nou = '',
    this.onTapMarker1,
    required this.costumeMarker,
  });

  Future<BitmapDescriptor> getBitmapFromType() async {
    return (costumeMarker)
        .toBitmapDescriptor(
      logicalSize: markerSize ?? Size(100.0.r, 100.0.r),
      imageSize: markerSize ?? Size(100.0.r, 100.0.r),
    );
  }

  Future<Marker> getWidgetGoogleMap({
    required int index,
    required num key,
    Function(MyMarker marker)? onTapMarker,
  }) async {
    return Marker(
      markerId: MarkerId(key.toString()),
      position: point,
      anchor: const Offset(0.5, 0.5),
      icon:await getBitmapFromType(),
      onTap: () => onTapMarker1?.call(item),
    );
  }


}

class MyPolyLine {
  LatLng? endPoint;
  num? key;
  String encodedPolyLine;
  Color? color;

  MyPolyLine({this.endPoint, this.key, this.encodedPolyLine = '', this.color});
}

class CountWidget extends StatelessWidget {
  const CountWidget({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text('$count'),
    );
  }
}
