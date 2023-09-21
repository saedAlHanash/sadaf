import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/util/my_style.dart';
import 'package:sadaf/features/settings/services/setting_service.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titleText: 'سياسة الخصوصية'),
      body: FutureBuilder(
        future: sl<SettingService>().getPrivacy(),
        builder: (context, snapShot) {
          if (!snapShot.hasData) {
            return Center(child: MyStyle.loadingWidget());
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
