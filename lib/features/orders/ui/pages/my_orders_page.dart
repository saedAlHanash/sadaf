import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/core/widgets/my_expansion/item_expansion.dart';
import 'package:sadaf/core/widgets/my_expansion/my_expansion_widget.dart';
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
      appBar: AppBarWidget(titleText: S.of(context).myOrders),
      body: BlocBuilder<OrdersCubit, OrdersInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          final listKeys = List<GlobalKey<ItemOrderWidgetState>>.from(
              state.result.map((e) => GlobalKey<ItemOrderWidgetState>()));
          if (list.isEmpty) {
            return NotFoundWidget(
              text: S.of(context).emptyOrders,
              icon: Assets.iconsNoCartResult,
            );
          }

          return SingleChildScrollView(
            child: MyExpansionWidget(
              onExpansion: (panelIndex, isExpanded) {
                listKeys[panelIndex].currentState?.updateExpanded(isExpanded);
              },
              elevation: 0.0,
              items: list
                  .mapIndexed(
                    (i, e) => ItemExpansion(
                      body: ItemOrderBody(order: e),
                      header: ItemOrderWidget(
                        key: listKeys[i],
                        order: e,
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
//if(date_pending)
// date_processing
// date_ready
// date_shipping
// date_completed
// date_canceled
// date_paymentFailed
// date_returned
