import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/cart/bloc/cart_cubut/cart_cubit.dart';
import 'package:sadaf/features/cart/service/cart_service.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/image_with_fav.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../home/ui/widget/screens/home_screen.dart';
import '../../../product/data/models/product.dart';

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
    return MyCardWidget(
      cardColor: AppColorManager.f6,
      elevation: 0.0,
      padding: const EdgeInsets.all(7.0).r,
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0).r,
      child: SizedBox(
        height: 170.0.h,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DrawableText(
                        fontFamily: FontManager.cairoBold,
                        text: product.name,
                        drawableAlin: DrawableAlin.between,
                        matchParent: true,
                        size: 14.0.sp,
                        drawableStart: IconButton(
                          onPressed: () {
                            onRemove.call(product.id);
                            context.read<CartCubit>().changeQuantity();
                          },
                          icon: Icon(
                            size: 24.0.r,
                            Icons.cancel_outlined,
                            color: AppColorManager.red,
                          ),
                        ),
                        padding:
                            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0).r,
                      ),
                      DrawableText(text: product.getOfferPrice),
                      if (product.isOffer)
                        StrikeThroughWidget(
                          child: DrawableText(
                            text: product.getPrice,
                            size: 14.0.spMin,
                          ),
                        )
                    ],
                  ),
                  AmountWidget1(
                    product: product,
                  ),
                ],
              ),
            ),
            ImageWithFav(
              product: product,
              width: 140.0.r,
              height: 140.0.r,
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
    amount = widget.product.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140.0.w,
      height: 60.0.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            elevation: 0.0,
            backgroundColor: Colors.black,
            mini: true,
            onPressed: () {
              setState(() => amount++);
              widget.product.quantity = amount;
              sl<CartService>().addToCart(widget.product, addQuantity: false,context: context);
              context.read<CartCubit>().changeQuantity();
            },
            child: const Icon(Icons.add, color: Colors.white),
          ),
          DrawableText(
            text: amount.toString(),
            color: Colors.black,
          ),
          FloatingActionButton(

            elevation: 0.0,
            backgroundColor: Colors.black,
            onPressed: () {
              if (amount <= 1) return;
              setState(() => amount--);
              widget.product.quantity = amount;
              sl<CartService>().addToCart(widget.product, addQuantity: false,context: context);
              context.read<CartCubit>().changeQuantity();
            },
            mini: true,
            child: const Icon(Icons.remove, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
