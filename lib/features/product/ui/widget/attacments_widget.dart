import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:pod_player/pod_player.dart';
import 'package:sadaf/core/api_manager/api_service.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/core/strings/enum_manager.dart';
import 'package:sadaf/core/widgets/my_card_widget.dart';
import 'package:sadaf/features/favorite/ui/widget/fav_btn_widget.dart';
import 'package:sadaf/features/product/ui/widget/share_btn.dart';

import '../../data/response/products_response.dart';

class CardAttachmentsSlider extends StatefulWidget {
  const CardAttachmentsSlider({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<CardAttachmentsSlider> createState() => _CardAttachmentsSliderState();
}

class _CardAttachmentsSliderState extends State<CardAttachmentsSlider> {
  late Attachment attachment;

  @override
  void initState() {
    attachment = widget.product.attachment.firstOrNull ??
        Attachment(
          link: '',
          type: AttachmentType.image,
        );
    super.initState();
  }

  Widget getAttachment() {

    switch (attachment.type) {
      case AttachmentType.image:
        return ImageMultiType(
          url: attachment.link,
          fit: BoxFit.fill,
          height: 318.0.h,
          width: 1.0.sw,
        );
      case AttachmentType.youtube:
      case AttachmentType.video:
        return VideoPlayerWidget(attachment: attachment);
      case AttachmentType.d3:
        return ImageMultiType(
          url: attachment.link,
          fit: BoxFit.fill,
          height: 318.0.h,
          width: 1.0.sw,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: AppColorManager.lightGray,
          height: 318.0.h,
          width: 1.0.sw,
          child: Stack(
            children: [
              getAttachment(),
              Positioned.directional(
                textDirection: Directionality.of(context),
                start: 20.0.r,
                top: 20.0.r,
                child: FavBtnWidget(product: widget.product),
              ),
              Positioned.directional(
                textDirection: Directionality.of(context),
                end: 20.0.r,
                top: 20.0.r,
                child: ShareBtnWidget(product: widget.product),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80.0.h,
          width: 1.0.sw,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0).r,
            itemCount: widget.product.attachment.length,
            itemBuilder: (_, i) {
              final item = widget.product.attachment[i];
              return InkWell(
                onTap: () => setState(() => attachment = item),
                splashColor: Colors.transparent,
                child: RoundImageWidget(
                  url: item.type == AttachmentType.youtube ? Icons.play_arrow : item.link,
                  height: 60.0.r,
                  width: 60.0.r,
                ),
              );
            },
            separatorBuilder: (context, index) => 5.0.horizontalSpace,
          ),
        )
      ],
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key, required this.attachment});

  final Attachment attachment;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  var initial = false;

  late final PodPlayerController controller;

  @override
  void initState() {
    if (widget.attachment.type == AttachmentType.youtube) {
      controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(
          widget.attachment.link,
        ),
      );
    } else {
      controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.network(
          widget.attachment.link,
        ),
      );
    }

    controller.initialise().then((value) => setState(() => initial = true));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PodVideoPlayer(
      frameAspectRatio: 1.3,
      controller: controller,
    );
  }
}
