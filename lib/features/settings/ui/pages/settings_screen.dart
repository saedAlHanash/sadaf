import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/helper/launcher_helper.dart';
import 'package:sadaf/core/strings/enum_manager.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:sadaf/features/profile/ui/widget/top_profile_widget.dart';
import 'package:sadaf/features/settings/ui/widget/drawer_widget.dart';
import 'package:sadaf/router/app_router.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var user = AppProvider.profile;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: TopProfileWidget(
          updateImage: false,
          children: [
            ItemMenu(
              name: S.of(context).myInfo,
              icon: Assets.iconsProfile,
            ),
            ItemMenu(
              name: S.of(context).myOrder,
              icon: Assets.iconsMyOrder,
            ),
            ItemMenu(
              name: S.of(context).faq,
              icon: Assets.iconsFaq,
            ),
            ItemMenu(
              name: S.of(context).termsAndConditions,
              icon: Assets.iconsTermsAndConditions,
            ),
            ItemMenu(
              name: S.of(context).aboutUs,
              icon: Assets.iconsAboutUs,
            ),
            ItemMenu(
              name: S.of(context).support,
              icon: Assets.iconsSupport,
            ),
            DrawableText(
              text: '',
              drawablePadding: 10.0.w,
              drawableEnd: GestureDetector(
                onTap: () => LauncherHelper.openPage('https://www.bandtech.co/'),
                child: ImageMultiType(
                  url: Assets.iconsBandtechLogo,
                  width: 80.0.spMin,
                  height: 40.0.spMin,
                ),
              ),
            ),
            15.0.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class ItemMenu extends StatelessWidget {
  const ItemMenu({Key? key, required this.name, required this.icon}) : super(key: key);

  final String name;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      radius: 0.01,
      onTap: () => onTapItem(context),
      child: Container(
        width: 1.0.sw,
        // height: 51.0.h,
        padding: const EdgeInsets.symmetric(vertical: 10.0).r,
        child: Column(
          children: [
            DrawableText(
              text: name,
              drawablePadding: 15.0.w,
              matchParent: true,
              drawableStart: ImageMultiType(
                url: icon,
                width: 20.0.spMin,
                height: 20.0.spMin,
                color: AppColorManager.mainColorDark,
              ),
              drawableEnd: ImageMultiType(
                url: Icons.keyboard_arrow_right_outlined,
                color: AppColorManager.mainColorDark,
                width: 20.0.r,
              ),
            ),
            Container(
              color: Colors.grey,
              height: 1.0.h,
              width: 1.0.sw,
              margin: const EdgeInsets.symmetric(vertical: 8.0).r,
            ),
          ],
        ),
      ),
    );
  }

  onTapItem(BuildContext context) {
    if (name == S.of(context).editProfile) {
      Navigator.pushNamed(context, RouteName.updateChoice);
      return;
    }

    if (name == S.of(context).myOrder) {
      Navigator.pushNamed(context, RouteName.myOrders);
      return;
    }

    if (name == S.of(context).about) {
      Navigator.pushNamed(context, RouteName.about);
      return;
    }

    if (name == S.of(context).policy) {
      Navigator.pushNamed(context, RouteName.privacy);
      return;
    }

    if (name == S.of(context).changeName) {
      Navigator.pushNamed(context, RouteName.update, arguments: UpdateType.name);
      return;
    }

    if (name == S.of(context).changeEmail) {
      Navigator.pushNamed(context, RouteName.update, arguments: UpdateType.email);
      return;
    }
    if (name == S.of(context).changePhone) {
      Navigator.pushNamed(context, RouteName.update, arguments: UpdateType.phone);
      return;
    }

    if (name == S.of(context).changeAddress) {
      Navigator.pushNamed(context, RouteName.update, arguments: UpdateType.address);
      return;
    }

    if (name == S.of(context).changePass) {
      Navigator.pushNamed(context, RouteName.update, arguments: UpdateType.pass);
      return;
    }

    if (name == S.of(context).myInfo) {
      Navigator.pushNamed(context, RouteName.myInfo);
      return;
    }

    if (name == S.of(context).wishList) {
      return;
    }

    if (name == S.of(context).faq) {
      Navigator.pushNamed(context, RouteName.faq);
      return;
    }

    if (name == S.of(context).termsAndConditions) {
      Navigator.pushNamed(context, RouteName.privacy);
      return;
    }

    if (name == S.of(context).aboutUs) {
      Navigator.pushNamed(context, RouteName.about);
      return;
    }

    if (name == S.of(context).support) {
      Navigator.pushNamed(context, RouteName.supportRoom);
      return;
    }
  }
}
