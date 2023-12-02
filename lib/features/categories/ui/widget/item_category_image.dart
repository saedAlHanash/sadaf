import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../data/response/category.dart';

class ItemCategoryImageWidget extends StatefulWidget {
  const ItemCategoryImageWidget({
    Key? key,
    this.selected = false,
    this.onTap,
    this.singleLine = false,
    required this.item,
    this.large = false,
    this.temp,
  }) : super(key: key);

  final Category item;

  final bool selected;
  final int? temp;
  final bool large;
  final bool singleLine;
  final Function(Category cat)? onTap;

  @override
  State<ItemCategoryImageWidget> createState() => _ItemCategoryImageWidgetState();
}

class _ItemCategoryImageWidgetState extends State<ItemCategoryImageWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.0.r,
      height: 70.0.r,
      child: InkWell(
        onTap: () => widget.onTap?.call(widget.item),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 7.0).w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageMultiType(
                url: widget.item.image,
                width: 28.0.r,
                height: 28.0.r,
                color:
                    (widget.selected) ? AppColorManager.mainColor : AppColorManager.gray,
              ),
              DrawableText(
                selectable: false,
                textAlign: TextAlign.center,
                text: widget.item.name,
                maxLines: widget.singleLine ? 1 : 2,
                color:
                    (widget.selected) ? AppColorManager.mainColor : AppColorManager.gray,
                fontFamily: FontManager.cairoBold,
                size: 12.0.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
