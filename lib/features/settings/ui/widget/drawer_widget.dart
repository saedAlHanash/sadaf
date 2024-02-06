import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/app/app_widget.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import '../../../auth/bloc/logout/logout_cubit.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColorManager.mainColorLight,
      shape: InputBorder.none,
      child: SingleChildScrollView(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              arrowColor: Colors.white,
              decoration: const BoxDecoration(color: AppColorManager.mainColorLight),
              accountName: DrawableText(
                matchParent: true,
                text: AppProvider.profile.name,
                color: Colors.white,
              ),
              accountEmail: DrawableText(
                matchParent: true,
                text: AppProvider.profile.emailOrPhone,
                color: Colors.white,
              ),
              currentAccountPicture: CircleImageWidget(
                url: AppProvider.profile.avatar,
              ),
              otherAccountsPictures: const [ImageMultiType(url: Assets.iconsLogoWhite)],
            ),

            ListTile(
              title: DrawableText(
                text: S.of(context).language,
                color: Colors.white,
              ),
              leading: const ImageMultiType(
                url: Assets.iconsLang,
                color: Colors.white,
              ),
              trailing: DrawableText(
                text: AppSharedPreference.getLangName(context),
                fontFamily: FontManager.cairoBold.name,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () => MyApp.setLocale(context, 'en'),
              enabled: AppSharedPreference.getLocal != 'en',
              title: DrawableText(
                text: S.of(context).en,
                color:
                    AppSharedPreference.getLocal != 'en' ? Colors.white : Colors.white54,
              ),
              trailing: AppSharedPreference.getLocal != 'en'
                  ? const ImageMultiType(
                      url: Icons.arrow_forward_ios,
                      color: Colors.white,
                    )
                  : null,
            ),
            ListTile(
              onTap: () => MyApp.setLocale(context, 'ar'),
              enabled: AppSharedPreference.getLocal != 'ar',
              title: DrawableText(
                text: S.of(context).ar,
                color:
                    AppSharedPreference.getLocal != 'ar' ? Colors.white : Colors.white54,
              ),
              trailing: AppSharedPreference.getLocal != 'ar'
                  ? const ImageMultiType(
                      url: Icons.arrow_forward_ios,
                      color: Colors.white,
                    )
                  : null,
            ),
            // ListTile(
            //   onTap: () {
            //     AppSharedPreference.cashLocal('ku').then(
            //       (value) => MyApp.setLocale(context),
            //     );
            //   },
            //   title: DrawableText(text: S.of(context).ku, color: Colors.white),
            //   trailing: const ImageMultiType(
            //     url: Icons.arrow_forward_ios,
            //     color: Colors.white,
            //   ),
            // ),

            40.0.verticalSpace,
            const _CurrencyWidget(),
            const Divider(indent: 0, endIndent: 0),
            ListTile(
              onTap: () => logout(),
              title: DrawableText(
                text: S.of(context).logout,
                color: Colors.white,
              ),
              leading: ImageMultiType(
                url: Assets.iconsLogout,
                width: 20.0.r,
                color: Colors.white,
                height: 20.0.r,
              ),
            ),
            ListTile(
              onTap: () => deleteAccount(),
              title: DrawableText(
                text: S.of(context).deleteAccount,
                color: Colors.white54,
              ),
              leading: const ImageMultiType(
                url: Icons.cancel,
                color: Colors.white54,
              ),
            ),
            10.0.verticalSpace,
          ],
        ),
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
                text: 'تسجبل الخروج ?',
                fontFamily: FontManager.cairoBold.name,
                size: 20.0.sp),
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
                fontFamily: FontManager.cairoBold.name,
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

class _CurrencyWidget extends StatefulWidget {
  const _CurrencyWidget({super.key});

  @override
  State<_CurrencyWidget> createState() => _CurrencyWidgetState();
}

class _CurrencyWidgetState extends State<_CurrencyWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: DrawableText(
            text: S.of(context).currency,
            color: Colors.white,
          ),
          leading: const ImageMultiType(
            url: Icons.attach_money,
            color: Colors.white,
          ),
          trailing: DrawableText(
            text: AppSharedPreference.currency.getName,
            fontFamily: FontManager.cairoBold.name,
            color: Colors.white,
          ),
        ),
        ListTile(
          onTap: () {
            setState(() {
              AppSharedPreference.setCurrency = CurrencyEnum.dollar;
            });
          },
          enabled: AppSharedPreference.currency != CurrencyEnum.dollar,
          title: DrawableText(
            text: S.of(context).dollar,
            color: AppSharedPreference.currency != CurrencyEnum.dollar
                ? Colors.white
                : Colors.white54,
          ),
          trailing: AppSharedPreference.currency != CurrencyEnum.dollar
              ? const ImageMultiType(
                  url: Icons.arrow_forward_ios,
                  color: Colors.white,
                )
              : null,
        ),
        ListTile(
          onTap: () {
            setState(() {
              AppSharedPreference.setCurrency = CurrencyEnum.dinar;
            });
          },
          enabled: AppSharedPreference.currency != CurrencyEnum.dinar,
          title: DrawableText(
            text: S.of(context).dinar,
            color: AppSharedPreference.currency != CurrencyEnum.dinar
                ? Colors.white
                : Colors.white54,
          ),
          trailing: AppSharedPreference.currency != CurrencyEnum.dinar
              ? const ImageMultiType(
                  url: Icons.arrow_forward_ios,
                  color: Colors.white,
                )
              : null,
        ),
      ],
    );
  }
}
