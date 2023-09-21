import 'package:drawable_text/drawable_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sadaf/core/api_manager/api_service.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/features/home/ui/widget/new_nav.dart';

import '../../features/cart/bloc/add_to_cart_cubit/add_to_cart_cubit.dart';
import '../../features/cart/bloc/update_cart_cubit/update_cart_cubit.dart';
import '../../features/favorite/bloc/add_favorite/add_favorite_cubit.dart';
import '../../features/favorite/bloc/get_favorite/get_favorite_cubit.dart';
import '../../features/notifications/bloc/notification_count_cubit/notification_count_cubit.dart';
import '../../main.dart';
import '../../router/app_router.dart';

import '../app_theme.dart';
import '../injection/injection_container.dart' as di;
import '../util/shared_preferences.dart';
import 'bloc/loading_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      String title = '';
      String body = '';

      if (notification != null) {
        title = notification.title ?? '';
        body = notification.body ?? '';
      } else {
        title = message.data['title'] ?? '';
        body = message.data['body'] ?? '';
      }

      if (AppSharedPreference.getActiveNotification()) {
        Note.showBigTextNotification(title: title, body: body);
      }

      AppSharedPreference.addNotificationCount();
      context.read<NotificationCountCubit>().changeCount();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loading = Builder(builder: (_) {
      return Visibility(
        visible: context.watch<LoadingCubit>().state.isLoading,
        child: SafeArea(
          child: Column(
            children: [
              const LinearProgressIndicator(),
              Expanded(
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ),
      );
    });

    return ScreenUtilInit(
      designSize: const Size(412, 770),
      // designSize: const Size(14440, 972),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        DrawableText.initial(
          headerSizeText: 18.0.spMin,
          initialHeightText: 1.8.spMin,
          titleSizeText: 15.0.spMin,
          initialSize: 16.0.spMin,
          renderHtml: false,
          selectable: false,
          initialColor: AppColorManager.black,
        );

        return MaterialApp(
          builder: (_, child) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => di.sl<LoadingCubit>()),
                BlocProvider(create: (_) => di.sl<AddFavoriteCubit>()),
                BlocProvider(create: (_) => di.sl<UpdateCartCubit>()),
                BlocProvider(create: (_) => di.sl<AddToCartCubit>()),
                BlocProvider(create: (_) => di.sl<FavoriteCubit>()..getFavorite(_)),
              ],
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Stack(
                  children: [child!, loading],
                ),
              ),
            );
          },
          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          onGenerateRoute: AppRoutes.routes,
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
