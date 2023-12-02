import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/response/manufacturers_response.dart';

class ItemManufacturerImageWidget extends StatefulWidget {
  const ItemManufacturerImageWidget({
    Key? key,
    this.selected = false,
    this.onTap,
    required this.item,
  }) : super(key: key);

  final Manufacturer item;
  final bool selected;
  final Function(Manufacturer item)? onTap;

  @override
  State<ItemManufacturerImageWidget> createState() => _ItemManufacturerImageWidgetState();
}

class _ItemManufacturerImageWidgetState extends State<ItemManufacturerImageWidget> {
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
          ),
        ),
      ),
    );
  }
}
