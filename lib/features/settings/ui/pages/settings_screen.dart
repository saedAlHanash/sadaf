import 'dart:ui';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/helper/launcher_helper.dart';
import 'package:sadaf/core/strings/enum_manager.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/features/settings/services/setting_service.dart';
import 'package:sadaf/features/profile/ui/widget/top_profile_widget.dart';
import 'package:sadaf/router/app_router.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import '../../../auth/bloc/logout/logout_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var user = AppSharedPreference.getUserModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TopProfileWidget(
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
            name: S.of(context).wishList,
            icon: Assets.iconsFav,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => logout(),
                child: DrawableText(
                  text: S.of(context).logout,
                  drawablePadding: 10.0.w,
                  drawableEnd: ImageMultiType(
                    url: Assets.iconsLogout,
                    width: 20.0.r,
                    height: 20.0.r,
                  ),
                ),
              ),
              DrawableText(
                text: S.of(context).deleteAccount,
                drawablePadding: 10.0.w,
                color: AppColorManager.red,
                drawableEnd: ImageMultiType(
                  url: Icons.delete_forever,
                  color: AppColorManager.red,
                  width: 20.0.r,
                  height: 20.0.r,
                ),
              ),
            ],
          ),
          const Divider(),
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
        ],
      ),
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
                        onTap: () {
                          context.read<LogoutCubit>().logout(context);
                          AppSharedPreference.logout();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteName.splash,
                            (route) => false,
                          );
                        },
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
                text: 'تأكيد حذف الحساب',
                fontFamily: FontManager.cairoBold,
                size: 19.0.sp),
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
                        onTap: () =>
                            context.read<DeleteAccountCubit>().deleteAccount(context),
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
      Navigator.pushNamed(context, RouteName.profile);
      return;
    }
    if (name == S.of(context).wishList) {
      return;
    }
    if (name == S.of(context).faq) {
      Navigator.pushNamed(context, RouteName.about);
      return;
    }
    if (name == S.of(context).termsAndConditions) {
      Navigator.pushNamed(context, RouteName.privacy);
      return;
    }
    if (name == S.of(context).aboutUs) {
      Navigator.pushNamed(context, RouteName.update, arguments: UpdateType.name);
      return;
    }
    if (name == S.of(context).support) {
      Navigator.pushNamed(context, RouteName.update, arguments: UpdateType.phone);
      return;
    }
  }
}
