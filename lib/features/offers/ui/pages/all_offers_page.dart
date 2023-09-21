import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/list_product_widget.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../generated/assets.dart';
import '../../bloc/offers_cubit/offers_cubit.dart';

class AllOffersPage extends StatelessWidget {
  const AllOffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        titleText: 'العروض',
      ),
      body: BlocBuilder<OffersCubit, OffersInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          if (state.result.isEmpty) {
            return const NotFoundWidget(
              icon: Assets.iconsNoFav,
              text: 'لا يوجد عروض',
            );
          }
          final offerProducts = state.result.map((e) => e.product).toList();
          return ListProductWidget(products: offerProducts);
        },
      ),
    );
  }
}
