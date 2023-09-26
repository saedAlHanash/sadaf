import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';

import '../../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import 'settings_screen.dart';

class UpdateChoicePage extends StatelessWidget {
  const UpdateChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titleText: 'تعديل الصفحة الشخصية'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0).r,
        child:  Column(
          children: [
            ItemMenu(
              name: S.of(context).changeName,
              icon: Assets.iconsChangeName,
            ),
            ItemMenu(
              name: S.of(context).changePhone,
              icon: Assets.iconsChangePhone,
            ),
            ItemMenu(
              name: S.of(context).changeAddress,
              icon: Assets.iconsLocation,
            ),
            ItemMenu(
              name: S.of(context).changePass,
              icon: Assets.iconsChangePass,
            ),
          ],
        ),
      ),
    );
  }
}
