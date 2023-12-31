import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/flash_deal/bloc/flash_deal_cubit/flash_deal_cubit.dart';
import 'package:sadaf/features/flash_deal/bloc/flash_deal_cubit/flash_deal_cubit.dart';

import '../../../../core/util/my_style.dart';
import '../../../home/ui/widget/flash_deal_widget.dart';

class FlashDealListPage extends StatelessWidget {
  const FlashDealListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlashDealsCubit, FlashDealsInitial>(
      builder: (context, state) {
        if (state.statuses.loading) {
          return MyStyle.loadingWidget();
        }
        return ListView.separated(
          itemCount: state.result.length,
          padding: const EdgeInsets.symmetric(vertical: 35.0).r,
          separatorBuilder: (_, i) {
            return 20.0.verticalSpace;
          },
          itemBuilder: (_, i) {
            return FlashDealWidgetFullCard(item: state.result[i]);
          },
        );
      },
    );
  }
}
