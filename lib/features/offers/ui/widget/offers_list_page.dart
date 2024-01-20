import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/features/product/data/response/products_response.dart';
import 'package:sadaf/features/product/ui/pages/price_screen.dart';

import '../../../../core/widgets/not_found_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../product/ui/widget/item_product.dart';
import '../../bloc/offers_cubit/offers_cubit.dart';

class OfferListPage extends StatelessWidget {
  const OfferListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OffersCubit, OffersInitial>(
      builder: (context, state) {
        if (state.result.isEmpty) {
          return NotFoundWidget(
            text: S.of(context).emptyOffers,
            icon: Assets.iconsNoOffersResult,
          );
        }
        return ListView.separated(
          itemCount: (state.result.length / 2).round(),
          padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 30.0).r,
          separatorBuilder: (_, i) {
            return 20.0.verticalSpace;
          },
          itemBuilder: (_, i) {
            return Row(
              children: [
                if (i == 0)
                  Column(
                    children: [
                      ImageMultiType(
                        url: Assets.iconsSummerSell,
                        height: 51.0.r,
                        width: 103.0.r,
                      ),
                      15.0.verticalSpace,
                      ItemProductOffer(item: state.result[i]),
                    ],
                  )
                else
                  ItemProductOffer(item: state.result[i]),
                35.0.horizontalSpace,
                if (i + 1 < state.result.length)
                  Transform.translate(
                    offset: Offset(0, -45.h),
                    child: ItemProductOffer(item: state.result[i + 1]),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
