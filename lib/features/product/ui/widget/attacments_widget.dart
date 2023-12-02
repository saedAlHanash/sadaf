import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/core/widgets/my_card_widget.dart';
import 'package:sadaf/features/favorite/ui/widget/fav_btn_widget.dart';

import '../../data/response/products_response.dart';

class CardAttachmentsSlider extends StatefulWidget {
  const CardAttachmentsSlider({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<CardAttachmentsSlider> createState() => _CardAttachmentsSliderState();
}

class _CardAttachmentsSliderState extends State<CardAttachmentsSlider> {
  var currentAttach = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: AppColorManager.gray,
          height: 318.0.h,
          width: 1.0.sw,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0).r,
                child: FavBtnWidget(product: widget.product),
              )
              ,
            ],
          ),
        ),
        SizedBox(
          height: 80.0.h,
          width: 1.0.sw,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0).r,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                splashColor: Colors.transparent,
                child: RoundImageWidget(
                  url: 'widget.images[index]',
                  height: 60.0.r,
                  width: 60.0.r,
                ),
              );
            },
            separatorBuilder: (context, index) => 5.0.horizontalSpace,
            itemCount: widget.product.attachment.length,
          ),
        )
      ],
    );
  }
}
