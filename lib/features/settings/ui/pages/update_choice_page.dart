import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';

import '../../../../../core/strings/app_string_manager.dart';
import '../../../../../generated/assets.dart';
import 'settings_screen.dart';

class UpdateChoicePage extends StatelessWidget {
  const UpdateChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titleText: 'تعديل الصفحة الشخصية'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0).r,
        child: const Column(
          children: [
            ItemMenu(
              name: AppStringManager.changeName,
              icon: Assets.iconsChangeName,
            ),
            ItemMenu(
              name: AppStringManager.changePhone,
              icon: Assets.iconsChangePhone,
            ),
            ItemMenu(
              name: AppStringManager.changeAddress,
              icon: Assets.iconsLocation,
            ),
            ItemMenu(
              name: AppStringManager.changePass,
              icon: Assets.iconsChangePass,
            ),
          ],
        ),
      ),
    );
  }
}
