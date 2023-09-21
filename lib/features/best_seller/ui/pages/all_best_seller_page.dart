import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/list_product_widget.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../generated/assets.dart';
import '../../bloc/best_seller_cubit/best_seller_cubit.dart';

class AllBestSellersPage extends StatelessWidget {
  const AllBestSellersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        titleText: 'الأكثر مبيعا',
      ),
      body: BlocBuilder<BestSellersCubit, BestSellersInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          if (state.result.isEmpty) {
            return const NotFoundWidget(
              icon: Assets.iconsNoSearch,
              text: 'لا يوجد نتائج',
            );
          }
          return ListProductWidget(products: state.result);
        },
      ),
    );
  }
}
