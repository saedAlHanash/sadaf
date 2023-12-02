import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return SizedBox(
      width: 60.0.r,
      height: 70.0.r,
      child: InkWell(
        onTap: () => widget.onTap?.call(widget.item),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.0).w,
          child: Ink(
            width: 28.0.r,
            height: 28.0.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (widget.selected)
                  ? widget.item.color
                  : widget.item.color.withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }
}
