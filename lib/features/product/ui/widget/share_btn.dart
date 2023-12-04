import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/features/product/data/response/products_response.dart';
import 'package:sadaf/generated/assets.dart';

class ShareBtnWidget extends StatelessWidget {
  const ShareBtnWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0.r,
      width: 50.0.r,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10.0).r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.5),
      ),
      child: InkWell(
        onTap: () {},
        child: const ImageMultiType(url: Assets.iconsShare),
      ),
    );
  }
}
