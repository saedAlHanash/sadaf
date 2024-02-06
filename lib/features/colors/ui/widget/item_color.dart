import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/features/colors/data/response/color_response.dart';

class ItemColorImageWidget extends StatefulWidget {
  const ItemColorImageWidget({
    Key? key,
    this.selected = false,
    this.onTap,
    required this.item,
  }) : super(key: key);

  final ColorModel item;
  final bool selected;
  final Function(ColorModel cat)? onTap;

  @override
  State<ItemColorImageWidget> createState() => _ItemColorImageWidgetState();
}

class _ItemColorImageWidgetState extends State<ItemColorImageWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap?.call(widget.item),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0).w,
        child: Container(
          width: (widget.selected) ? 60.0.r : 30.0.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: (widget.selected) ? widget.item.color : Colors.black,
            ),
            color: (widget.selected)
                ? widget.item.color
                : widget.item.color.withOpacity(0.6),
          ),
          child: (widget.selected)
              ? ImageMultiType(
                  url: Icons.check,
                  color: isColorDark(widget.item.color)
                      ? Colors.white
                      : AppColorManager.mainColor,
                )
              : null,
        ),
      ),
    );
  }
}
