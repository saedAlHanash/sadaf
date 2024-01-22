import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/util/my_style.dart';
import 'package:sadaf/core/widgets/not_found_widget.dart';
import 'package:sadaf/features/settings/services/setting_service.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).aboutUs),
      body: FutureBuilder(
        future: sl<SettingService>().getAbout(),
        builder: (context, snapShot) {
          if (!snapShot.hasData) {
            return Center(child: MyStyle.loadingWidget());
          }
          if (snapShot.data!.isEmpty) {
            return const NotFoundWidget(
                text: 'No Data', icon: Assets.iconsNoSearchResult,);
          }
          return DrawableText(
            text: snapShot.data!,
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0).r,
          );
        },
      ),
    );
  }
}
