import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/features/product/data/response/products_response.dart';

import '../../generated/assets.dart';

class ImageWithFav extends StatefulWidget {
  const ImageWithFav({super.key, required this.product, this.height, this.width});

  final Product product;

  final double? height;

  final double? width;

  @override
  State<ImageWithFav> createState() => _ImageWithFavState();
}

class _ImageWithFavState extends State<ImageWithFav> {
  var isError = false;

  @override
  Widget build(BuildContext context) {
    final f = isError
        ? const AssetImage(Assets.iconsLogo)
        : CachedNetworkImageProvider(
            widget.product.thumbnail,
          );
    return Container(
      height: widget.height ?? double.infinity,
      width: widget.width ?? double.infinity,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0.r),
        image: DecorationImage(
          filterQuality: FilterQuality.low,
          fit: BoxFit.cover,
          opacity: isError ? 0.1 : 1,
          onError: (exception, stackTrace) => setState(() => isError = true),
          image: f as ImageProvider,
        ),
      ),
    );
  }
}
