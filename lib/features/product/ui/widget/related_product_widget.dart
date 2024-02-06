import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/features/product/ui/widget/item_product.dart';

import '../../../../generated/l10n.dart';
import '../../bloc/product_by_id_cubit/product_by_id_cubit.dart';

class RelatedProductWidget extends StatelessWidget {
  const RelatedProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductByIdCubit, ProductByIdInitial>(
      builder: (context, state) {
        if (state.result.relatedProducts.isEmpty) return 0.0.verticalSpace;
        return Column(
          children: [
            DrawableText(
              text: S.of(context).related_products,
              size: 18.0.sp,
              fontFamily: FontManager.cairo.name,
              matchParent: true,
            ),
            SizedBox(
              height: 250.0.h,
              width: 1.0.sw,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: state.result.relatedProducts.length,
                separatorBuilder: (_, i) => 20.0.horizontalSpace,
                itemBuilder: (_, i) {
                  return ItemRelatedProductProduct(item: state.result.relatedProducts[i]);
                },
              ),
            )
          ],
        );
      },
    );
  }
}
