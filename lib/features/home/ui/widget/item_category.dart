import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/round_image_widget.dart';

import '../../../../router/app_router.dart';
import '../../../catigories/data/models/category.dart';

class ItemCategory extends StatelessWidget {
  const ItemCategory({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, RouteName.category, arguments: category),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RoundImageWidget(
            url: category.cover,
            height: 75.0.r,
            width: 75.0.r,
          ),
          5.0.verticalSpace,
          DrawableText(text: category.name),
        ],
      ),
    );
  }
}
