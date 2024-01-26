import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/util/my_style.dart';
import 'package:sadaf/features/settings/services/setting_service.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).termsAndConditions),
      body: FutureBuilder(
        future: sl<SettingService>().getPrivacy(),
        builder: (context, snapShot) {
          if (!snapShot.hasData) {
            return Center(child: MyStyle.loadingWidget());
          }

          if (snapShot.data == null) {
            return const NotFoundWidget(
              text: 'No Data',
              icon: Assets.iconsNoSearchResult,
            );
          }

          final list = snapShot.data!;
          return ListView.builder(
            itemCount: list.length,
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0).r,
            itemBuilder: (_, i) {
              return Column(
                children: [
                  DrawableText(
                    text: list[i].name.toUpperCase(),
                    size: 24.0.sp,
                    matchParent: true,
                  ),
                  20.0.verticalSpace,
                  DrawableText(
                    text: list[i].name,
                    matchParent: true,
                    color: Colors.grey,
                    size: 14.0.sp,
                  ),
                  30.0.verticalSpace,
                ],
              );
            },
          );
        },
      ),
    );
  }
}
