import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seo_renderer/renderers/image_renderer/image_renderer_vm.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../generated/assets.dart';
import '../../api_manager/api_service.dart';
import '../../strings/app_color_manager.dart';

enum ImageType { tempImg, assetImg, assetSvg, network, file, networkSvg }

class ImageMultiType extends StatefulWidget {
  const ImageMultiType({
    Key? key,
    required this.url,
    this.height,
    this.width,
    this.fit,
    this.color,
    this.file,
    this.temp,
  }) : super(key: key);

  final String url;
  final XFile? file;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;
  final int? temp;

  @override
  State<ImageMultiType> createState() => ImageMultiTypeState();
}

class ImageMultiTypeState extends State<ImageMultiType> {
  var type = ImageType.network;

  void initialType() {
    if (widget.file != null) {
      type = ImageType.file;
      return;
    }
    if (widget.url.isEmpty) {
      type = ImageType.tempImg;
    } else if (widget.url.contains('assets/') && widget.url.contains('.svg')) {
      type = ImageType.assetSvg;
    } else if (widget.url.endsWith('svg')) {
      type = ImageType.networkSvg;
    } else if (widget.url.contains('assets/') && widget.url.contains('.png')) {
      type = ImageType.assetImg;
    } else {
      type = ImageType.network;
    }
  }

  @override
  Widget build(BuildContext context) {
    initialType();
    switch (type) {
      case ImageType.assetImg:
        return Image.asset(
          widget.url,
          height: widget.height,
          width: widget.width,
          color: widget.color,
          fit: widget.fit,
        );
      case ImageType.assetSvg:
        return SvgPicture.asset(
          widget.url,
          height: widget.height,
          width: widget.width,
          color: widget.color,
          fit: widget.fit ?? BoxFit.contain,
        );
      case ImageType.network:
        return CachedNetworkImage(
          imageUrl: widget.url,
          height: widget.height,
          width: widget.width,
          color: widget.color,
          filterQuality: FilterQuality.low,
          fit: widget.fit ?? BoxFit.cover,
          progressIndicatorBuilder: (context, url, progress) {
            return Shimmer(
              duration: const Duration(seconds: 2),
              color: AppColorManager.gray,
              direction: const ShimmerDirection.fromLTRB(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0.r),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  color: AppColorManager.lightGray,
                  height: widget.height,
                  width: widget.width,
                ),
              ),
            );
          },
          alignment: Alignment.center,
          errorWidget: (context, url, error) {
            return const Opacity(
              opacity: 0.1,
              child: ImageMultiType(url: Assets.iconsLogo),
            );
          },
        );
      case ImageType.file:
        var byte = widget.file?.readAsBytes();
        return FutureBuilder(
          future: byte,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.memory(snapshot.requireData);
            } else {
              return 0.0.verticalSpace;
            }
          },
        );
      case ImageType.networkSvg:
        return SizedBox(
          height: widget.height,
          width: widget.width,
        );
      // return FutureBuilder(
      //   future: getSvgFromLink(widget.url, widget.temp ?? 0),
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return SizedBox(
      //         height: widget.height,
      //         width: widget.width,
      //       );
      //     }
      //     return SizedBox(
      //       height: widget.height,
      //       width: widget.width,
      //       child: ScalableImageWidget(
      //           si: ScalableImage.fromSvgString(snapshot.data ?? '')),
      //     );
      //   },
      // );
      case ImageType.tempImg:
        return Image.asset(
          Assets.iconsLogo,
          color: widget.color ?? AppColorManager.mainColor.withOpacity(0.6),
          height: widget.height,
          width: widget.width,
        );
    }
  }
}
