import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/core/util/my_style.dart';
import 'package:sadaf/core/widgets/card_slider_widget.dart';
import 'package:sadaf/features/home/ui/widget/flash_deal_widget.dart';
import 'package:sadaf/features/home/ui/widget/item_category.dart';
import 'package:sadaf/features/home/ui/widget/search_widget.dart';
import 'package:sadaf/generated/assets.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../router/app_router.dart';
import '../../../../product/ui/widget/item_product.dart';
import '../../../bloc/home_cubit/home_cubit.dart';
import '../../../bloc/slider_cubit/slider_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeInitial>(
      builder: (context, state) {
        if (state.statuses.loading) {
          return MyStyle.loadingWidget();
        }
        final offerProducts = state.result.offers.map((e) => e.product).toList();
        return SingleChildScrollView(
          child: Column(
            children: [
              //سلايدر الصور
              BlocBuilder<SliderCubit, SliderInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  if (state.result.isEmpty) return 0.0.verticalSpace;
                  return CardImageSlider(
                    images: state.result.map((e) => e.cover).toList(),
                    height: 200.0.h,
                  );
                },
              ),

              const TopSearchBar(),
              //التصنيفات
              SizedBox(
                height: 120.0.h,
                child: ListView.separated(
                  itemCount: state.result.categories.length,
                  padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, i) {
                    final item = state.result.categories[i];
                    return ItemCategory(category: item);
                  },
                  separatorBuilder: (_, i) => 12.0.horizontalSpace,
                ),
              ),
              20.0.verticalSpace,
              DrawableText.titleList(
                text: S.of(context).flash_deal,
                padding: MyStyle.pagePadding,
                drawableEnd: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteName.offers);
                  },
                  child: DrawableText(
                    text: S.of(context).see_all,
                    color: AppColorManager.gray,
                  ),
                ),
              ),
              SizedBox(
                height: 105.0.h,
                width: 1.0.sw,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: offerProducts.length,
                  itemBuilder: (_, i) {
                    return const FlashDealWidget();
                  },
                ),
              ),
              20.0.verticalSpace,
              DrawableText.titleList(
                text: S.of(context).new_arrival,
                padding: MyStyle.pagePadding,
                drawableEnd: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteName.offers);
                  },
                  child: DrawableText(
                    text: S.of(context).see_all,
                    color: AppColorManager.gray,
                  ),
                ),
              ),
              SizedBox(
                height: 355.0.h,
                width: 1.0.sw,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (_, i) {
                    return const ItemProduct1();
                  },
                ),
              ),

              30.0.verticalSpace,
              //سلايدر الصور
              BlocBuilder<SliderCubit, SliderInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  if (state.result.isEmpty) return 0.0.verticalSpace;
                  return CardImageSlider(
                    images: state.result.map((e) => e.cover).toList(),
                    height: 150.0.h,
                  );
                },
              ),
              30.0.verticalSpace,
              DrawableText.titleList(
                text: S.of(context).offer,
                padding: MyStyle.pagePadding,
                drawableEnd: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteName.offers);
                  },
                  child: DrawableText(
                    text: S.of(context).see_all,
                    color: AppColorManager.gray,
                  ),
                ),
              ),
              SizedBox(
                height: 130.0.h,
                width: 1.0.sw,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (_, i) {
                    return const ItemProduct2();
                  },
                ),
              ),
              25.0.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}

class StrikeThroughWidget extends StatelessWidget {
  const StrikeThroughWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        ImageMultiType(
          url: Assets.iconsDMRMq,
          fit: BoxFit.fitWidth,
          width: 70.0.w,
        ),
      ],
    );
  }
}
