import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/features/favorite/bloc/get_favorite/get_favorite_cubit.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../generated/assets.dart';
import '../../../../router/app_router.dart';
import '../../../settings/services/setting_service.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () async {
      if (AppSharedPreference.isLogin) {
        await FavoriteCubit.getFavoriteApi();
      }
      await sl<SettingService>().getWhatsUp();
      await sl<SettingService>().getFacebook();
      await sl<SettingService>().getPhone();
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, RouteName.home);
    });

    return Scaffold(
      body: Container(
        width: 1.0.sw,
        height: 1.0.sh,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.iconsBackCover),
            fit: BoxFit.fill,
          ),
        ),
        padding: MyStyle.authPagesPadding,
        child: Center(
          child: Image.asset(Assets.iconsLogo),
        ),
      ),
    );
  }
}