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
import 'package:sadaf/features/orders/ui/widget/item_order_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../product/ui/widget/item_product.dart';
import '../../bloc/order_by_id_cubit/order_by_id_cubit.dart';
import '../../bloc/orders_cubit/orders_cubit.dart';
import '../../data/response/orders_response.dart';

class TrackingOrderPage extends StatelessWidget {
  const TrackingOrderPage({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).trackingOrder),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30.0).r,
              child: Column(
                children: [
                  _ItemDashedData(title: S.of(context).yourOrder, data: '#${order.id}'),
                  20.0.verticalSpace,
                  _ItemDashedData(title: S.of(context).deliveryDate, data: '#321354'),
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
                    initialValue: order.address.toString(),
                    iconWidget: Padding(
                      padding: const EdgeInsets.all(10.0).r,
                      child: ImageMultiType(url: Assets.iconsLocator),
                    ),
                  ),
                  MyTextFormOutLineWidget(
                    enable: false,
                    label: S.of(context).receiverPhone,
                    initialValue: order.address.receiverPhone,
                    iconWidget: Padding(
                      padding: const EdgeInsets.all(10.0).r,
                      child: ImageMultiType(url: Assets.iconsYourPhone),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 400.0.h,
            width: double.infinity,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.42796133580664, -122.085749655962),
                zoom: 14.4746,
              ),
              onMapCreated: (GoogleMapController controller) {
                // _controller.complete(controller);
              },
            ),
          )
        ],
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
        Expanded(
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
