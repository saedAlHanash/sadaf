import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../data/models/product.dart';

class AmountWidget extends StatefulWidget {
  const AmountWidget({super.key, this.onChange, required this.product});

  final Function(int amount)? onChange;
  final Product product;

  @override
  State<AmountWidget> createState() => _AmountWidgetState();
}

class _AmountWidgetState extends State<AmountWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.0.w,
      height: 60.0.h,
      decoration: BoxDecoration(
        color: AppColorManager.mainColorDark,
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(30.0.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              setState(() => widget.product.quantity++);
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
          DrawableText(
            text: widget.product.quantity.toString(),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              if (widget.product.quantity <= 1) return;
              setState(() => widget.product.quantity--);
            },
            icon: const Icon(Icons.remove, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
