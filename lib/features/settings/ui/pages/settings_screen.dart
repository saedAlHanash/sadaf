import 'dart:ui';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sadaf/core/api_manager/api_service.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/helper/launcher_helper.dart';
import 'package:sadaf/core/strings/enum_manager.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:sadaf/core/widgets/images/image_multi_type.dart';
import 'package:sadaf/features/settings/services/setting_service.dart';
import 'package:sadaf/features/settings/ui/pages/privacy_page.dart';
import 'package:sadaf/router/app_router.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../generated/assets.dart';
import '../../../auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import '../../../auth/bloc/logout/logout_cubit.dart';
import 'about_page.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var user = AppSharedPreference.getUserModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!AppSharedPreference.isLogin) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const NotFoundWidget(
            text: 'يجب تسجبل الدخول لرؤية الإعدادات',
            icon: Assets.iconsNoSearch,
          ),
          MyButton(
            text: 'تسجيل الدخول ؟',
            onTap: () => Navigator.pushNamed(context, RouteName.login),
          )
        ],
      );
    }
    return Column(
      children: [
        SizedBox(
          height: 230.0.h,
          width: 1.0.sw,
          child: Stack(
            children: [
              ImageMultiType(
                url: Assets.iconsLogo,
                height: 180.0.h,
                width: 1.0.sw,
                fit: BoxFit.cover,
              ),
              Positioned(
                right: 0.0,
                left: 0.0,
                bottom: 0.0,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                      height: 120.0.spMin,
                      width: 120.0.spMin,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: MyStyle.lightShadow,
                        border: Border.all(color: AppColorManager.whit, width: 7.0.spMin),
                        color: AppColorManager.offWhit,
                      ),
                      child: const ImageMultiType(
                        url: Assets.iconsLogo,
                      )),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DrawableText(
                    text: user.name,
                    fontFamily: FontManager.cairoBold,
                  ),
                  DrawableText(
                    text: user.phone,
                  ),
                  10.0.verticalSpace,
                  const ItemMenu(
                    name: AppStringManager.editProfile,
                    icon: Assets.iconsUser,
                  ),
                  const ItemMenu(
                    name: AppStringManager.myOrder,
                    icon: Assets.iconsOrders,
                  ),
                  const ItemMenu(
                    name: AppStringManager.notification,
                    icon: Assets.iconsNotifications,
                  ),
                  const ItemMenu(
                    name: AppStringManager.about,
                    icon: Assets.iconsInfo,
                  ),
                  const ItemMenu(
                    name: AppStringManager.policy,
                    icon: Assets.iconsPolicy,
                  ),
                  DrawableText(
                    text: AppStringManager.contact,
                    matchParent: true,
                    textAlign: TextAlign.center,
                    color: AppColorManager.black,
                    padding: const EdgeInsets.symmetric(vertical: 3.0).h,
                  ),
                  Builder(builder: (_) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        0.0.verticalSpace,
                        IconButton(
                          onPressed: () async {
                            final phone = await sl<SettingService>().getPhone();
                            LauncherHelper.callPhone(phone: phone);
                          },
                          iconSize: 50.0.spMin,
                          icon: const ImageMultiType(url: Assets.iconsCall),
                        ),
                        IconButton(
                          onPressed: () async {
                            final facebook = await sl<SettingService>().getFacebook();

                            LauncherHelper.openPage(facebook);
                          },
                          iconSize: 50.0.spMin,
                          icon: const ImageMultiType(url: Assets.iconsFb),
                        ),
                        IconButton(
                          onPressed: () async {
                            final whatsUp = await sl<SettingService>().getWhatsUp();
                            LauncherHelper.openPage(whatsUp);
                          },
                          iconSize: 50.0.spMin,
                          icon: const ImageMultiType(url: Assets.iconsWhatsApp),
                        ),
                        0.0.verticalSpace,
                      ],
                    );
                  }),
                  20.0.verticalSpace,
                  DrawableText(
                    text: 'صمم بواسطة: ',
                    color: Colors.black,
                    size: 20.0.sp,
                    drawablePadding: 10.0.w,
                    drawableEnd: GestureDetector(
                      onTap: () => LauncherHelper.openPage('https://www.bandtech.co/'),
                      child: ImageMultiType(
                        url: Assets.iconsBandtechLogo,
                        width: 100.0.spMin,
                        height: 50.0.spMin,
                      ),
                    ),
                  ),
                  20.0.verticalSpace,
                  MyButton(
                    text: AppStringManager.logout,
                    onTap: logout,
                  ),
                  5.0.verticalSpace,
                  MyButton(
                    text: 'حذف الحساب',
                    color: Colors.red,
                    onTap: deleteAccount,
                  ),
                  20.0.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void logout() {
    NoteMessage.showBottomSheet1(
      context,
      BlocProvider.value(
        value: context.read<LogoutCubit>(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            10.0.verticalSpace,
            DrawableText(
                text: 'تسجبل الخروج ?', fontFamily: FontManager.cairoBold, size: 20.0.sp),
            const Divider(endIndent: 10.0, indent: 10.0),
            DrawableText(
              text: 'هل أنت متأكد من تسجيل الخروج؟ ',
              color: AppColorManager.textColor,
              size: 20.0.spMin,
              padding: const EdgeInsets.symmetric(vertical: 30.0).h,
            ),
            Row(
              children: [
                10.0.horizontalSpace,
                Flexible(
                  flex: 1,
                  child: BlocConsumer<LogoutCubit, LogoutInitial>(
                    listenWhen: (p, c) => c.statuses.done,
                    listener: (context, state) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteName.splash,
                        (route) => false,
                      );
                    },
                    builder: (context, state) {
                      if (state.statuses.loading) {
                        return MyStyle.loadingWidget();
                      }
                      return MyButton(
                        width: 1.0.sw,
                        text: 'نعم',
                        onTap: () => context.read<LogoutCubit>().logout(context),
                      );
                    },
                  ),
                ),
                10.0.horizontalSpace,
                Flexible(
                  flex: 1,
                  child: MyButton(
                    text: 'لا',
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                10.0.horizontalSpace,
              ],
            ),
            20.0.verticalSpace,
          ],
        ),
      ),
    );
  }

  void deleteAccount() {
    NoteMessage.showBottomSheet1(
      context,
      BlocProvider.value(
        value: context.read<DeleteAccountCubit>(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            10.0.verticalSpace,
            DrawableText(
                text: 'تأكيد حذف الحساب', fontFamily: FontManager.cairoBold, size: 19.0.sp),
            const Divider(endIndent: 10.0, indent: 10.0),
            DrawableText(
              text: 'هل أنت متأكد من حذف الحساب؟ ',
              color: AppColorManager.textColor,
              size: 18.0.spMin,
              padding: const EdgeInsets.symmetric(vertical: 30.0).h,
            ),
            Row(
              children: [
                10.0.horizontalSpace,
                Flexible(
                  flex: 1,
                  child: BlocConsumer<DeleteAccountCubit, DeleteAccountInitial>(
                    listenWhen: (p, c) => c.statuses.done,
                    listener: (context, state) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteName.splash,
                        (route) => false,
                      );
                    },
                    builder: (context, state) {
                      if (state.statuses.loading) {
                        return MyStyle.loadingWidget();
                      }
                      return MyButton(
                        width: 1.0.sw,
                        text: 'نعم',
                        onTap: () => context.read<DeleteAccountCubit>().deleteAccount(context),
                      );
                    },
                  ),
                ),
                10.0.horizontalSpace,
                Flexible(
                  flex: 1,
                  child: MyButton(
                    text: 'لا',
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                10.0.horizontalSpace,
              ],
            ),
            20.0.verticalSpace,
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
    var switchState = AppSharedPreference.getActiveNotification();
    return InkWell(
      onTap: name == AppStringManager.notification ? null : () => onTapItem(context),
      child: Container(
        width: 1.0.sw,
        height: 51.0.h,
        decoration: BoxDecoration(
          color: AppColorManager.lightGray,
          borderRadius: BorderRadius.circular(200.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0).r,
        margin: const EdgeInsets.symmetric(vertical: 10.0).h,
        child: Row(
          children: [
            Expanded(
              child: DrawableText(
                text: name,
                drawablePadding: 15.0.w,
                padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                drawableStart: ImageMultiType(
                  url: icon,
                  width: 20.0.spMin,
                  height: 20.0.spMin,
                ),
              ),
            ),
            name == AppStringManager.notification
                ? StatefulBuilder(builder: (context, state) {
                    return FlutterSwitch(
                      height: 30.0.h,
                      activeColor: AppColorManager.whit,
                      activeToggleColor: AppColorManager.mainColor,
                      value: switchState,
                      onToggle: (value) {
                        state(() => switchState = value);
                        AppSharedPreference.cashActiveNotification(switchState);
                      },
                    );
                  })
                : Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColorManager.e4,
                    size: 13.0.r,
                  )
          ],
        ),
      ),
    );
  }

  onTapItem(BuildContext context) {
    switch (name) {
      case AppStringManager.editProfile:
        Navigator.pushNamed(context, RouteName.updateChoice);
        break;
      case AppStringManager.myOrder:
        Navigator.pushNamed(context, RouteName.myOrders);
        break;

      case AppStringManager.notification:
        break;

      case AppStringManager.about:
        Navigator.pushNamed(context, RouteName.about);

        break;

      case AppStringManager.policy:
        Navigator.pushNamed(context, RouteName.privacy);
        break;

      case AppStringManager.changeName:
        Navigator.pushNamed(context, RouteName.update, arguments: UpdateType.name);
        break;
      case AppStringManager.changePhone:
        Navigator.pushNamed(context, RouteName.update, arguments: UpdateType.phone);
        break;
      case AppStringManager.changeAddress:
        Navigator.pushNamed(context, RouteName.update, arguments: UpdateType.address);
        break;
      case AppStringManager.changePass:
        Navigator.pushNamed(context, RouteName.update, arguments: UpdateType.pass);
        break;
    }
  }
}
