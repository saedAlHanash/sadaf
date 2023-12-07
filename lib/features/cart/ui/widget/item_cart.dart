import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import 'package:sadaf/features/cart/service/cart_service.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/image_with_fav.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../generated/assets.dart';
import '../../../home/ui/widget/screens/home_screen.dart';
import '../../../product/data/response/products_response.dart';
import '../../../product/data/response/products_response.dart';

class ItemProductCart extends StatelessWidget {
  const ItemProductCart({
    super.key,
    required this.product,
    required this.onRemove,
  });

  final Product product;

  final Function(int id) onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorManager.f8,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0).r,
      child: SizedBox(
        height: 95.0.h,
        child: Row(
          children: [
            ImageMultiType(
              url: Assets.iconsTemp5,
              width: 80.0.r,
              height: 80.0.r,
            ),
            8.0.horizontalSpace,
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                         DrawableText(
                          text: product.name,
                          maxLines: 1,
                          matchParent: true,
                        ),
                        DrawableText(
                          text: product.price,
                          color: AppColorManager.black,
                          matchParent: true,
                          drawablePadding: 10.0.w,
                          drawableAlin: DrawableAlin.withText,
                          drawableEnd: DrawableText(
                            text: product.discountPrice,
                            color: AppColorManager.redPrice,
                            size: 12.0.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AmountWidget1(
                    product: product,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AmountWidget1 extends StatefulWidget {
  const AmountWidget1({super.key, required this.product});

  final Product product;

  @override
  State<AmountWidget1> createState() => _AmountWidget1State();
}

class _AmountWidget1State extends State<AmountWidget1> {
  var amount = 1;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 95.0.w,
      height: 26.0.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 25.0.r,
            width: 25.0.r,
            alignment: Alignment.center,
            color: AppColorManager.black,
            child: InkWell(
              onTap: () {
                setState(() => amount++);
                sl<CartService>()
                    .addToCart(widget.product, addQuantity: false, context: context);
              },
              child: Icon(Icons.add, color: Colors.white,size: 18.0.r),
            ),
          ),
          DrawableText(
            text: amount.toString(),
            color: Colors.black,
          ),
          Container(
            height: 25.0.r,
            width: 25.0.r,
            alignment: Alignment.center,
            color: AppColorManager.black,
            child: InkWell(
              onTap: () {
                if (amount <= 1) return;
                setState(() => amount--);

                sl<CartService>()
                    .addToCart(widget.product, addQuantity: false, context: context);

              },
              child: Icon(Icons.remove, color: Colors.white,size: 18.0.r),
            ),
          ),
        ],
      ),
    );
  }
}
