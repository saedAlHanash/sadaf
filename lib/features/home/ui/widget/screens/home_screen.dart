import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/core/util/my_style.dart';
import 'package:sadaf/core/widgets/card_slider_widget.dart';
import 'package:sadaf/features/home/ui/widget/item_category.dart';
import 'package:sadaf/features/home/ui/widget/search_widget.dart';
import 'package:sadaf/generated/assets.dart';


import '../../../../../router/app_router.dart';
import '../../../../product/ui/widget/item_product.dart';
import '../../../bloc/home_cubit/home_cubit.dart';
import '../../../bloc/slider_cubit/slider_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children: [
          const TopSearchBar(),
          Expanded(
            child: BlocBuilder<HomeCubit, HomeInitial>(
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
                          return CardSlider(
                            images: state.result.map((e) => e.cover).toList(),
                            height: 160.0.h,
                          );
                        },
                      ),
                      10.0.verticalSpace,
                      //التصنيفات
                      SizedBox(
                        height: 120.0.h,
                        child: ListView.separated(
                          itemCount: state.result.categories.length,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0).w,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, i) {
                            final item = state.result.categories[i];
                            return ItemCategory(category: item);
                          },
                          separatorBuilder: (_, i) => 12.0.horizontalSpace,
                        ),
                      ),
                      DrawableText.titleList(
                        text: 'العروض',
                        padding: MyStyle.pagePadding,
                        drawableEnd: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RouteName.offers);
                          },
                          child: const DrawableText(
                            text: 'عرض الكل',
                            color: AppColorManager.gray,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 255.0.h,
                        width: 1.0.sw,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: offerProducts.length,
                          itemBuilder: (_, i) {
                            final item = offerProducts[i];
                            return ItemProduct(product: item);
                          },
                        ),
                      ),
                      DrawableText.titleList(
                        text: 'الأكثر مبيعا',
                        padding: MyStyle.pagePadding,
                        drawableEnd: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RouteName.bestSeller);
                          },
                          child: const DrawableText(
                            text: 'عرض الكل',
                            color: AppColorManager.gray,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 255.0.h,
                        width: 1.0.sw,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.result.bestSeller.length,
                          itemBuilder: (_, i) {
                            final item = state.result.bestSeller[i];
                            return ItemProduct(product: item);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
