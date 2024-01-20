import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/core/util/my_style.dart';
import 'package:sadaf/core/widgets/card_slider_widget.dart';
import 'package:sadaf/features/flash_deal/ui/widget/flash_deal_widget.dart';
import 'package:sadaf/features/categories/ui/widget/item_category.dart';
import 'package:sadaf/features/home/ui/widget/search_widget.dart';
import 'package:sadaf/generated/assets.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../router/app_router.dart';
import '../../../../categories/bloc/categories_cubit/categories_cubit.dart';
import '../../../../flash_deal/bloc/flash_deal_cubit/flash_deal_cubit.dart';
import '../../../../offers/bloc/offers_cubit/offers_cubit.dart';
import '../../../../product/bloc/new_arrival_cubit/new_arrival_cubit.dart';
import '../../../../product/ui/widget/item_product.dart';
import '../../../bloc/banner_cubit/banner_cubit.dart';
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
        return SingleChildScrollView(
          child: Column(
            children: [
              //سلايدر الصور
              const _BannerWidget(),
              20.0.verticalSpace,
              //التصنيفات
              const _CategoriesWidget(),
              20.0.verticalSpace,
              const _FlashDealListWidget(),
              20.0.verticalSpace,
              const _NewArrival(),
              20.0.verticalSpace,
              //سلايدر الصور
              const _BannerWidget1(),
              20.0.verticalSpace,
              const _Offers(),
              25.0.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}

class _CategoriesWidget extends StatelessWidget {
  const _CategoriesWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeInitial>(
      builder: (context, state) {
        if (state.statuses.loading) {
          return MyStyle.loadingWidget();
        }
        if(state.result.categories.isEmpty)return 0.0.verticalSpace;
        return SizedBox(
          height: 120.0.h,
          child: ListView.separated(
            itemCount: state.result.categories.length,
            padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) {
              final category = state.result.categories[i];
              return ItemCategory(category: category);
            },
            separatorBuilder: (_, i) => 12.0.horizontalSpace,
          ),
        );
      },
    );
  }
}

class _BannerWidget extends StatelessWidget {
  const _BannerWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 275.0.h,
      width: double.infinity,
      child: Stack(
        children: [
          BlocBuilder<BannerCubit, BannerInitial>(
            builder: (context, state) {
              if (state.result.isEmpty) return 0.0.verticalSpace;
              return CardImageSlider(
                images: state.result.map((e) => e.image).toList(),
                height: 275.0.h,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0).r,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: SearchFieldWidget(),
                ),
                34.0.horizontalSpace,
                InkWell(
                  onTap: () async {},
                  child: ImageMultiType(
                    url: Icons.notifications,
                    height: 20.0.r,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerWidget1 extends StatelessWidget {
  const _BannerWidget1();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderCubit, SliderInitial>(
      builder: (context, state) {
        if (state.statuses.loading) {
          return MyStyle.loadingWidget();
        }
        if (state.result.isEmpty) return 0.0.verticalSpace;
        return CardImageSlider(
          images: state.result.map((e) => e.image).toList(),
          height: 150.0.h,
        );
      },
    );
  }
}

class _FlashDealListWidget extends StatelessWidget {
  const _FlashDealListWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeInitial>(
      builder: (context, state) {
        if (state.statuses.loading) {
          return MyStyle.loadingWidget();
        }
        if (state.result.flashDeals.isEmpty) return 0.0.verticalSpace;
        return Column(
          children: [
            DrawableText.titleList(
              text: S.of(context).flash_deal,
              padding: MyStyle.pagePadding,
              drawableEnd: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.offers, arguments: 1);
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
                scrollDirection: Axis.horizontal,
                itemCount: state.result.flashDeals.length,
                itemBuilder: (_, i) {
                  return FlashDealWidget(item: state.result.flashDeals[i]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _NewArrival extends StatelessWidget {
  const _NewArrival();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeInitial>(
      builder: (context, state) {
        if (state.statuses.loading) {
          return MyStyle.loadingWidget();
        }
        if (state.result.newProducts.isEmpty) return 0.0.verticalSpace;
        return Column(
          children: [
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
                itemCount: state.result.newProducts.length,
                itemBuilder: (_, i) {
                  return ItemLargeProduct(product: state.result.newProducts[i]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Offers extends StatelessWidget {
  const _Offers();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeInitial>(
      builder: (context, state) {
        if (state.statuses.loading) {
          return MyStyle.loadingWidget();
        }
        if (state.result.offers.isEmpty) return 0.0.verticalSpace;
        return Column(
          children: [
            DrawableText.titleList(
              text: S.of(context).offer,
              padding: MyStyle.pagePadding,
              drawableEnd: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.offers, arguments: 0);
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
                itemCount: state.result.offers.length,
                itemBuilder: (_, i) {
                  return ItemHorizontalProduct(item: state.result.offers[i]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
