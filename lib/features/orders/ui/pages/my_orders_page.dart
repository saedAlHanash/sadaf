import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/core/widgets/not_found_widget.dart';
import 'package:sadaf/features/orders/ui/widget/item_order_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/orders_cubit/orders_cubit.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBarWidget(titleText: S.of(context).myOrders),
      body: BlocBuilder<OrdersCubit, OrdersInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (list.isEmpty) {
            return const NotFoundWidget(
              text: 'لا توجد طلبات',
              icon: Assets.iconsNoOrder,
            );
          }

          return ListView.separated(
            itemBuilder: (_, i) {
              final item = list[i];
              return ItemOrderWidget(order: item);
            },
            separatorBuilder: (context, index) => 10.0.verticalSpace,
            itemCount: list.length,
          );
        },
      ),
    );
  }
}
