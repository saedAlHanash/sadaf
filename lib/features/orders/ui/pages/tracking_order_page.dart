import 'dart:async';

import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/core/strings/enum_manager.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:sadaf/core/widgets/not_found_widget.dart';
import 'package:sadaf/features/map/data/my_marker.dart';
import 'package:sadaf/features/map/ui/pages/map_page.dart';
import 'package:sadaf/features/orders/ui/widget/item_order_widget.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../driver/bloc/driver_location_cubit/driver_location_cubit.dart';
import '../../../map/bloc/map_controller_cubit/map_controller_cubit.dart';
import '../../../product/ui/widget/item_product.dart';
import '../../bloc/order_by_id_cubit/order_by_id_cubit.dart';
import '../../bloc/orders_cubit/orders_cubit.dart';
import '../../data/response/orders_response.dart';

class TrackingOrderPage extends StatefulWidget {
  const TrackingOrderPage({super.key});

  @override
  State<TrackingOrderPage> createState() => _TrackingOrderPageState();
}

class _TrackingOrderPageState extends State<TrackingOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).trackingOrder),
      body: BlocBuilder<OrderByIdCubit, OrderByIdInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(30.0).r,
                  child: Column(
                    children: [
                      _ItemDashedData(
                          title: S.of(context).yourOrder, data: '#${state.result.id}'),
                      20.0.verticalSpace,
                      _ItemDashedData(
                          title: S.of(context).deliveryDate,
                          data: state.result.estimatedTime?.formatDateTime ?? '-'),
                      20.0.verticalSpace,
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: ImageMultiType(
                          url: Assets.iconsDoneIcon,
                          width: 32.0.r,
                        ),
                        enabled: false,
                        horizontalTitleGap: 15.0.w,
                        trailing: InkWell(
                          onTap: () {},
                          child: ImageMultiType(
                            url: Assets.iconsChat,
                            height: 30.0.r,
                            width: 30.0.r,
                          ),
                        ),
                        title: DrawableText(
                          text: S.of(context).readyToDeliver,
                          size: 18.0.sp,
                          fontFamily: FontManager.cairoBold.name,
                        ),
                        subtitle: DrawableText(
                          text:
                              '${S.of(context).estimatedFor} ${DateTime.now().formatDateTime}',
                          size: 14.0.sp,
                          color: AppColorManager.c6e,
                        ),
                      ),
                      15.0.verticalSpace,
                      MyTextFormOutLineWidget(
                        enable: false,
                        label: S.of(context).yourAddress,
                        initialValue: state.result.address.toString(),
                        iconWidget: Padding(
                          padding: const EdgeInsets.all(10.0).r,
                          child: const ImageMultiType(url: Assets.iconsLocator),
                        ),
                      ),
                      MyTextFormOutLineWidget(
                        enable: false,
                        label: S.of(context).receiverPhone,
                        initialValue: state.result.address.receiverPhone,
                        iconWidget: Padding(
                          padding: const EdgeInsets.all(10.0).r,
                          child: const ImageMultiType(url: Assets.iconsYourPhone),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 400.0.h,
                width: double.infinity,
                child: MapTracking(order: state.result),
              )
            ],
          );
        },
      ),
    );
  }
}

class _ItemDashedData extends StatelessWidget {
  const _ItemDashedData({required this.title, required this.data});

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DrawableText(
          size: 16.0.sp,
          text: title.toUpperCase(),
        ),
        7.0.horizontalSpace,
        const Expanded(
          child: MySeparator(),
        ),
        7.0.horizontalSpace,
        DrawableText(
          size: 16.0.sp,
          text: data,
          fontFamily: FontManager.cairoBold.name,
        ),
      ],
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

class MapTracking extends StatefulWidget {
  const MapTracking({super.key, required this.order});

  final Order order;

  @override
  State<MapTracking> createState() => _MapTrackingState();
}

class _MapTrackingState extends State<MapTracking> {
  late final Timer t;

  Set<Marker> markers = {};
  GoogleMapController? controller;
  Set<Polyline> polyLines = {};
  late MapControllerCubit mapControllerCubit;

  @override
  void initState() {
    ///initial map controller
    mapControllerCubit = context.read<MapControllerCubit>();
    final driverPoint = widget.order.driver.mapAddress.latLng;
    final orderPoint = widget.order.address.mapAddress.latLng;
    mapControllerCubit.addPolyLine(
      start: widget.order.driver.mapAddress.latLng,
      end: widget.order.address.mapAddress.latLng,
      addPathLength: true,
    );

    if (driverPoint == null) return;

    mapControllerCubit.addMarker(
      marker: MyMarker(
        key: 22,
        point: driverPoint,
        //
        costumeMarker: ImageMultiType(
          height: 100.0.r,
          width: 100.0.r,
          url: Assets.iconsTrack,
        ),
      ),
    );

    if (orderPoint == null) return;
    mapControllerCubit.addMarker(
      marker: MyMarker(
        key: 23,
        point: orderPoint,
        //
        costumeMarker: ImageMultiType(
          height: 100.0.r,
          width: 100.0.r,
          url: Assets.iconsLocator,
        ),
      ),
    );

    mapControllerCubit
      ..centerPointMarkers()
      ..update();

    t = Timer.periodic(
      const Duration(seconds: 16),
      (timer) {
        context.read<DriverLocationCubit>().getDriverLocation(orderId: widget.order.id);
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }

  Future<List<Future<Marker>>> initMarker(MapControllerInitial state) async {
    loggerObject.wtf(state.markers.length);
    return state.markers.keys.mapIndexed(
      (i, key) async {
        return await state.markers[key]!.getWidgetGoogleMap(
          index: i,
          key: key,
        );
      },
    ).toList();
  }

  List<Polyline> initPolyline(MapControllerInitial state) {
    return state.polyLines.values.mapIndexed(
      (i, e) {
        return Polyline(
          points: e.first,
          color: e.second,
          width: 5.0.r.toInt(),
          polylineId: PolylineId(e.hashCode.toString()),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DriverLocationCubit, DriverLocationInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            final point = state.result.latLng;
            if (point == null) return;
            mapControllerCubit.addMarker(
              marker: MyMarker(
                key: 22,
                point: point,
                costumeMarker: ImageMultiType(
                  url: Assets.iconsTrack,
                  height: 100.0.r,
                  width: 100.0.r,
                ),
              ),
            );
          },
        ),
        BlocListener<MapControllerCubit, MapControllerInitial>(
          listenWhen: (p, c) => p.markerNotifier != c.markerNotifier,
          listener: (context, state) async {
            final listMarkers = await initMarker(state);
            for (var e in listMarkers) {
              markers.add(await e);
            }
            if (mounted) setState(() {});
          },
        ),
        BlocListener<MapControllerCubit, MapControllerInitial>(
          listenWhen: (p, c) => p.polylineNotifier != c.polylineNotifier,
          listener: (context, state) async {
            polyLines
              ..clear()
              ..addAll(initPolyline(state));

            setState(() {});
          },
        ),
        BlocListener<MapControllerCubit, MapControllerInitial>(
          listener: (context, state) async {
            if (state.centerZoomPoints.length > 1) {
              Future.delayed(const Duration(seconds: 1), () {
                controller?.animateCamera(
                  CameraUpdate.newLatLngBounds(
                    calculateLatLngBounds(state.centerZoomPoints),
                    40.0.r,
                  ),
                );
              });
            }
          },
        ),
      ],
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.order.address.mapAddress.latLng ?? initialLocation,
          zoom: 14.4746,
        ),
        markers: markers,
        polylines: polyLines,
        onMapCreated: (GoogleMapController controller) {
          this.controller = controller;
        },
      ),
    );
  }
}
