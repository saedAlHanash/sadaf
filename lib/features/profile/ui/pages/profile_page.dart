import 'package:flutter/material.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:sadaf/core/widgets/my_button.dart';

import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../widget/top_profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = AppSharedPreference.getUserModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(zeroHeight: true),
      body: SingleChildScrollView(
        child: TopProfileWidget(
          title: S.of(context).profile,
          children: [
            MyTextFormOutLineWidget(
              enable: false,
              label: S.of(context).userName,
              icon: Assets.iconsUserName,
              initialValue: user.name,
            ),
            if (!user.emailOrPhone.contains('@'))
              MyTextFormOutLineWidget(
                enable: false,
                label: S.of(context).phoneNumber,
                initialValue: user.emailOrPhone,
                icon: Assets.iconsYourPhone,
              ),
            if (user.emailOrPhone.contains('@'))
              MyTextFormOutLineWidget(
                enable: false,
                label: S.of(context).yourEmail,
                initialValue: user.emailOrPhone,
                icon: Assets.iconsEmail,
              ),
            MyTextFormOutLineWidget(
              enable: false,
              label: S.of(context).yourAddress,
              icon: Assets.iconsLocator,
              initialValue: user.address,
            ),
            MyButton(
              text: 'UPDATE',
              onTap: () {
                Navigator.pushNamed(context, RouteName.updateChoice);
              },
            ),
          ],
        ),
      ),
    );
  }
}
