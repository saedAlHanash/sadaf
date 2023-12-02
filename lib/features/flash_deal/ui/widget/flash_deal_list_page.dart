import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../home/ui/widget/flash_deal_widget.dart';

class FlashDealListPage extends StatelessWidget {
  const FlashDealListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 4,
      padding: EdgeInsets.symmetric(vertical: 35.0).r,
      separatorBuilder: (_, i) {
        return 20.0.verticalSpace;
      },
      itemBuilder: (_, i) {
        return const FlashDealWidgetFullCard();
      },
    );
  }
}
