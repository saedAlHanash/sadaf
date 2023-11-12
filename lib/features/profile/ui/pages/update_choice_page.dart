import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';

import '../../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../widget/top_profile_widget.dart';
import '../../../settings/ui/pages/settings_screen.dart';

class UpdateChoicePage extends StatelessWidget {
  const UpdateChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(zeroHeight: true),
      body: SingleChildScrollView(
        child: TopProfileWidget(
          title: S.of(context).profile,
          children: [
            ItemMenu(
              name: S.of(context).changeName,
              icon: Assets.iconsUserName,
            ),
            if (!AppSharedPreference.getUserModel.emailOrPhone.contains('@'))
              ItemMenu(
                name: S.of(context).changePhone,
                icon: Assets.iconsChangePhone,
              ),
            if (AppSharedPreference.getUserModel.emailOrPhone.contains('@'))
              ItemMenu(
                name: S.of(context).changeEmail,
                icon: Assets.iconsEmail,
              ),
            ItemMenu(
              name: S.of(context).changeAddress,
              icon: Assets.iconsLocator,
            ),
            ItemMenu(
              name: S.of(context).changePass,
              icon: Assets.iconsLock,
            ),
          ],
        ),
      ),
    );
  }
}
