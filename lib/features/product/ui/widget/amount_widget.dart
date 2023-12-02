import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/response/products_response.dart';

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
    return SizedBox(
      width: 111.0.w,
      height: 32.0.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 25.0.r,
            width: 25.0.r,
            color: Colors.black,
            child: InkWell(
              onTap: () {
                setState(() => widget.product.quantity++);
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
          DrawableText(
            text: widget.product.quantity.toString(),
          ),
          Container(
            height: 25.0.r,
            width: 25.0.r,
            color: Colors.black,
            child: InkWell(
              onTap: () {
                if (widget.product.quantity <= 1) return;
                setState(() => widget.product.quantity--);
              },
              child: const Icon(Icons.remove, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
