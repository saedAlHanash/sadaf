import 'package:drawable_text/drawable_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/generated/assets.dart';
import 'package:sadaf/core/api_manager/api_service.dart';
import '../../features/cart/bloc/add_to_cart_cubit/add_to_cart_cubit.dart';
import '../../features/cart/bloc/clear_cart_cubit/clear_cart_cubit.dart';
import '../../features/cart/bloc/coupon_cubit/coupon_cubit.dart';
import '../../features/cart/bloc/decrease_cubit/decrease_cubit.dart';
import '../../features/cart/bloc/get_cart_cubit/get_cart_cubit.dart';
import '../../features/cart/bloc/increase_cubit/increase_cubit.dart';
import '../../features/cart/bloc/remove_from_cart_cubit/remove_from_cart_cubit.dart';
import '../../features/categories/bloc/categories_cubit/categories_cubit.dart';
import '../../features/categories/bloc/sub_categories_cubit/sub_categories_cubit.dart';
import '../../features/chat/bloc/support_rooms_cubit/support_rooms_cubit.dart';
import '../../features/colors/bloc/colors_cubit/colors_cubit.dart';
import '../../features/favorite/bloc/add_favorite/add_favorite_cubit.dart';
import '../../features/favorite/bloc/get_favorite/get_favorite_cubit.dart';
import '../../features/flash_deal/bloc/flash_deal_cubit/flash_deal_cubit.dart';
import '../../features/governors/bloc/governors_cubit/governors_cubit.dart';
import '../../features/home/bloc/banner_cubit/banner_cubit.dart';
import '../../features/home/bloc/slider_cubit/slider_cubit.dart';
import '../../features/manufacturers/bloc/manufacturerss_cubit/manufacturers_cubit.dart';

import '../../features/notifications/bloc/notifications_cubit/notifications_cubit.dart';
import '../../features/offers/bloc/offers_cubit/offers_cubit.dart';
import '../../features/product/bloc/new_arrival_cubit/new_arrival_cubit.dart';
import '../../features/profile/bloc/profile_cubit/profile_cubit.dart';
import '../../generated/l10n.dart';
import '../../main.dart';
import '../../router/app_router.dart';
import '../app_theme.dart';
import '../injection/injection_container.dart';
import '../injection/injection_container.dart';
import '../util/shared_preferences.dart';
import 'bloc/loading_cubit.dart';
import 'package:image_multi_type/image_multi_type.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static Future<void> setLocale(BuildContext context, Locale newLocale) async {
    final state = context.findAncestorStateOfType<_MyAppState>();
    await state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    S.load(Locale(AppSharedPreference.getLocal));
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

    });
    setImageMultiTypeErrorImage(
      const Opacity(
        opacity: 0.3,
        child: ImageMultiType(
          url: Assets.iconsLogo,
          height: 30.0,
          width: 30.0,
        ),
      ),
    );
    super.initState();
  }

  Future<void> setLocale(Locale locale) async {
    AppSharedPreference.cashLocal(locale.languageCode);
    await S.load(locale);
    setState(() {});
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
      designSize: const Size(375, 812),
      // designSize: const Size(14440, 972),
      minTextAdapt: true,
      // splitScreenMode: true,
      builder: (context, child) {
        DrawableText.initial(
          headerSizeText: 28.0.sp,
          initialHeightText: 1.5.sp,
          titleSizeText: 20.0.sp,
          initialSize: 16.0.sp,
          renderHtml: false,
          selectable: false,
          initialColor: AppColorManager.black,
        );

        return MaterialApp(
          navigatorKey: sl<GlobalKey<NavigatorState>>(),
          locale: Locale(AppSharedPreference.getLocal),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          builder: (_, child) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => sl<CouponCubit>()),
                BlocProvider(create: (_) => sl<LoadingCubit>()),
                BlocProvider(create: (_) => sl<IncreaseCubit>()),
                BlocProvider(create: (_) => sl<DecreaseCubit>()),
                BlocProvider(create: (_) => sl<AddToCartCubit>()),
                BlocProvider(create: (_) => sl<ClearCartCubit>()),
                BlocProvider(create: (_) => sl<AddFavoriteCubit>()),
                BlocProvider(create: (_) => sl<SubCategoriesCubit>()),
                BlocProvider(create: (_) => sl<RemoveFromCartCubit>()),
                BlocProvider(create: (_) => sl<CartCubit>()..getCart()),
                BlocProvider(create: (_) => sl<BannerCubit>()..getBanner()),
                BlocProvider(create: (_) => sl<SliderCubit>()..getSlider()),
                BlocProvider(create: (_) => sl<ColorsCubit>()..getColors()),
                BlocProvider(create: (_) => sl<OffersCubit>()..getOffers(_)),
                BlocProvider(create: (_) => sl<ProfileCubit>()..getProfile()),
                BlocProvider(create: (_) => sl<FavoriteCubit>()..getFavorite()),
                BlocProvider(create: (_) => sl<GovernorsCubit>()..getGovernors()),
                BlocProvider(create: (_) => sl<FlashDealsCubit>()..getFlashDeals()),
                BlocProvider(create: (_) => sl<CategoriesCubit>()..getCategories()),
                BlocProvider(create: (_) => sl<NotificationsCubit>()..getNotifications()),
                BlocProvider(
                  create: (_) => sl<SupportMessagesCubit>()..getSupportMessages(),
                ),
                BlocProvider(
                  create: (_) => sl<ManufacturersCubit>()..getManufacturers(),
                ),
                BlocProvider(
                  create: (_) => sl<NewArrivalProductsCubit>()..getNewArrivalProducts(),
                ),
              ],
              child: BlocListener<AddToCartCubit, AddToCartInitial>(
                listenWhen: (p, c) => c.statuses.done,
                listener: (context, state) {
                  context.read<CartCubit>().getCart();
                },
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

BuildContext? get ctx => sl<GlobalKey<NavigatorState>>().currentContext;
