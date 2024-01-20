import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/features/home/ui/widget/search_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/list_product_widget.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../flash_deal/ui/widget/flash_deal_list.dart';
import '../../bloc/offers_cubit/offers_cubit.dart';
import '../widget/offers_list_page.dart';

class AllOffersPage extends StatefulWidget {
  const AllOffersPage({super.key, required this.index});

  final int index;

  @override
  State<AllOffersPage> createState() => _AllOffersPageState();
}

class _AllOffersPageState extends State<AllOffersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    if (widget.index > 0) {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => _tabController.animateTo(1),
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        titleText: S.of(context).flash_deal,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
        child: Column(
          children: [
            const SearchOffersFieldWidget(),
            20.0.verticalSpace,
            SizedBox(
              height: 42.h,
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                controller: _tabController,
                indicator: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColorManager.mainColorLight,
                      AppColorManager.mainColorLight,
                      AppColorManager.mainColor,
                      AppColorManager.mainColor,
                    ],
                  ),
                  color: AppColorManager.mainColor,
                ),
                labelStyle: TextStyle(
                  fontSize: 16.0.sp,
                  fontFamily: FontManager.cairoBold.name,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 16.0.sp,
                  fontFamily: FontManager.cairoBold.name,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: AppColorManager.ac,
                tabs: [
                  Tab(text: S.of(context).offer.toUpperCase()),
                  Tab(text: S.of(context).flash_deal.toUpperCase()),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  OfferListPage(),
                  FlashDealListPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
