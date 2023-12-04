import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:pod_player/pod_player.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/features/product/ui/widget/add_to_cart_btn.dart';
import 'package:sadaf/generated/assets.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../../cart/bloc/add_to_cart_cubit/add_to_cart_cubit.dart';
import '../../bloc/product_by_id_cubit/product_by_id_cubit.dart';
import '../widget/attacments_widget.dart';
import '../widget/description_screen.dart';
import '../widget/price_screen.dart';
import '../widget/review_screen.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> with SingleTickerProviderStateMixin {
  var initial = false;

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        actions: [
          IconButton(
            onPressed: () {
              context.read<AddToCartCubit>().goToCart(true);
              while (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            icon: ImageMultiType(
              url: Assets.iconsCart,
              width: 25.0.r,
              height: 25.0.r,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BlocBuilder<ProductByIdCubit, ProductByIdInitial>(
        builder: (context, state) {
          return AddToCartBtn(product: state.result);
        },
      ),
      body: BlocBuilder<ProductByIdCubit, ProductByIdInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                    child: Column(
                  children: [
                    CardAttachmentsSlider(
                      product: state.result,
                    ),
                    20.0.verticalSpace,
                    SizedBox(
                      height: 42.h,
                      child: Stack(
                        children: [
                          Positioned(
                            width: 1.0.sw,
                            height: 2.0.h,
                            bottom: 0.0,
                            child: Container(
                              height: 1.0.h,
                              color: AppColorManager.lightGray,
                            ),
                          ),
                          TabBar(
                            controller: _tabController,
                            labelColor: AppColorManager.mainColor,
                            unselectedLabelColor: AppColorManager.ac,
                            tabs: [
                              Tab(text: S.of(context).price.toUpperCase()),
                              Tab(text: S.of(context).description.toUpperCase()),
                              Tab(text: S.of(context).reviews.toUpperCase()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: const [
                PriceScreen(),
                DescriptionProductScreen(),
                ReviewProductScreen(),
              ],
            ),
          );
        },
      ),
    );
  }
}
