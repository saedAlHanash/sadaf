import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/coupon_cubit/coupon_cubit.dart';
import '../../bloc/get_cart_cubit/get_cart_cubit.dart';

class CouponWidget extends StatefulWidget {
  const CouponWidget({super.key});

  @override
  State<CouponWidget> createState() => _CouponWidgetState();
}

class _CouponWidgetState extends State<CouponWidget> {
  final controller = TextEditingController();

  var appliedCoupon = '';
  bool doneCoupon = false;

  @override
  void initState() {
    controller.text = context.read<CartCubit>().state.result.couponCode;
    appliedCoupon = controller.text;
    if (appliedCoupon.isNotEmpty) doneCoupon = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        appliedCoupon = state.result.couponCode;
        controller.text = appliedCoupon;
        if (appliedCoupon.isNotEmpty) {
          setState(() => doneCoupon = true);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0).r,
        child: MyTextFormOutLineWidget(
          controller: controller,
          label: S.of(context).coupon_code,
          onChanged: (p0) {
            if (appliedCoupon.isNotEmpty &&
                controller.text == appliedCoupon &&
                !doneCoupon) {
              setState(() => doneCoupon = true);
            } else if (doneCoupon) {
              setState(() => doneCoupon = false);
            }
          },
          innerPadding: const EdgeInsets.symmetric(horizontal: 10.0).w,
          iconWidgetLift: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0).r,
            child: SizedBox(
              width: 74.0.w,
              child: BlocBuilder<CouponCubit, CouponInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return TextButton(
                    onPressed: () {
                      context
                          .read<CouponCubit>()
                          .applyCoupon(couponCode: controller.text);
                    },
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(AppColorManager.ee)),
                    child: DrawableText(
                      text: S.of(context).apply,
                      size: 11.0.sp,
                    ),
                  );
                },
              ),
            ),
          ),
          iconWidget: doneCoupon
              ? const ImageMultiType(
                  url: Icons.done,
                  color: Colors.green,
                )
              : null,
        ),
      ),
    );
  }
}
