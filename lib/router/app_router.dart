import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadaf/core/strings/enum_manager.dart';
import 'package:sadaf/features/auth/data/request/signup_request.dart';
import 'package:sadaf/features/best_seller/bloc/best_seller_cubit/best_seller_cubit.dart';
import 'package:sadaf/features/best_seller/ui/pages/all_best_seller_page.dart';
import 'package:sadaf/features/catigories/data/models/category.dart';
import 'package:sadaf/features/home/ui/pages/search_result_page.dart';
import 'package:sadaf/features/notifications/ui/pages/notifications_page.dart';
import 'package:sadaf/features/product/data/models/product.dart';
import 'package:sadaf/features/product/ui/pages/product_page.dart';

import '../core/injection/injection_container.dart' as di;
import '../features/auth/bloc/confirm_code_cubit/confirm_code_cubit.dart';
import '../features/auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import '../features/auth/bloc/login_cubit/login_cubit.dart';
import '../features/auth/bloc/logout/logout_cubit.dart';
import '../features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import '../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../features/auth/bloc/signup_cubit/signup_cubit.dart';
import '../features/auth/ui/pages/confirm_code_page.dart';
import '../features/auth/ui/pages/forget_passowrd_page.dart';
import '../features/auth/ui/pages/login_page.dart';
import '../features/auth/ui/pages/reset_password_page.dart';
import '../features/auth/ui/pages/signup_page.dart';
import '../features/auth/ui/pages/splash_screen_page.dart';
import '../features/cart/bloc/cart_cubut/cart_cubit.dart';
import '../features/cart/bloc/coupon_cubit/coupon_cubit.dart';
import '../features/cart/bloc/create_order_cubit/create_order_cubit.dart';
import '../features/catigories/bloc/category_by_id_cubit/category_by_id_cubit.dart';
import '../features/catigories/ui/pages/categories_page.dart';
import '../features/home/bloc/home_cubit/home_cubit.dart';
import '../features/home/bloc/search_cubit/search_cubit.dart';
import '../features/home/bloc/slider_cubit/slider_cubit.dart';
import '../features/home/ui/pages/home_page.dart';
import '../features/notifications/bloc/notifications_cubit/notifications_cubit.dart';
import '../features/offers/bloc/offers_cubit/offers_cubit.dart';
import '../features/offers/ui/pages/all_offers_page.dart';
import '../features/orders/bloc/orders_cubit/orders_cubit.dart';
import '../features/orders/ui/pages/my_orders_page.dart';
import '../features/product/bloc/product_by_id_cubit/product_by_id_cubit.dart';
import '../features/settings/bloc/update_user_cubit/update_user_cubit.dart';
import '../features/settings/ui/pages/about_page.dart';
import '../features/settings/ui/pages/privacy_page.dart';
import '../features/settings/ui/pages/update_choice_page.dart';
import '../features/settings/ui/pages/update_page.dart';

class AppRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
    var screenName = settings.name;

    switch (screenName) {
      //region auth
      case RouteName.splash:
        //region
        return MaterialPageRoute(builder: (_) => const SplashScreenPage());
      //endregion
      case RouteName.signup:
        //region
        {
          return MaterialPageRoute(
            builder: (context) {
              final providers = [
                BlocProvider(create: (context) => di.sl<SignupCubit>()),
              ];
              return MultiBlocProvider(
                providers: providers,
                child: const SignupPage(),
              );
            },
          );
        }
      //endregion
      case RouteName.myAddress:
        //region
        {
          final providers = [
            BlocProvider(create: (context) => di.sl<SignupCubit>()),
          ];
          return MaterialPageRoute(
            builder: (context) {
              return MultiBlocProvider(
                providers: providers,
                child: MyAddress(request: settings.arguments as SignupRequest),
              );
            },
          );
        }
      //endregion
      case RouteName.login:
        //region
        {
          final providers = [
            BlocProvider(create: (context) => di.sl<LoginCubit>()),
          ];
          return MaterialPageRoute(
            builder: (context) {
              return MultiBlocProvider(
                providers: providers,
                child: const LoginPage(),
              );
            },
          );
        }
      //endregion
      case RouteName.forgetPassword:
        //region
        {
          final providers = [
            BlocProvider(create: (context) => di.sl<ResendCodeCubit>()),
          ];
          return MaterialPageRoute(
            builder: (context) {
              return MultiBlocProvider(
                providers: providers,
                child: const ForgetPasswordPage(),
              );
            },
          );
        }
      //endregion
      case RouteName.resetPasswordPage:
        //region
        {
          final providers = [
            BlocProvider(create: (context) => di.sl<ResetPasswordCubit>()),
          ];
          return MaterialPageRoute(
            builder: (context) {
              return MultiBlocProvider(
                providers: providers,
                child: const ResetPasswordPage(),
              );
            },
          );
        }
      //endregion
      case RouteName.confirmCode:
        //region
        {
          final providers = [
            BlocProvider(create: (context) => di.sl<ConfirmCodeCubit>()),
            BlocProvider(create: (context) => di.sl<ResendCodeCubit>()),
          ];
          return MaterialPageRoute(
            builder: (context) {
              return MultiBlocProvider(
                providers: providers,
                child: const ConfirmCodePage(),
              );
            },
          );
        }
      //endregion
      //endregion

      //region home
      case RouteName.home:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<HomeCubit>()..getHome(_)),
          BlocProvider(create: (_) => di.sl<SliderCubit>()..getSlider(_)),
          BlocProvider(create: (_) => di.sl<CartCubit>()..getDeliveryPrice()),
          BlocProvider(create: (_) => di.sl<LogoutCubit>()),
          BlocProvider(create: (_) => di.sl<DeleteAccountCubit>()),
          BlocProvider(create: (_) => di.sl<CreateOrderCubit>()),
          BlocProvider(create: (_) => di.sl<CouponCubit>()),
        ];
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: const Homepage(),
            );
          },
        );
      //endregion

      case RouteName.offers:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<OffersCubit>()..getOffers(_)),
        ];
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: const AllOffersPage(),
            );
          },
        );
      //endregion

      case RouteName.bestSeller:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<BestSellersCubit>()..getBestSellers(_)),
        ];
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: const AllBestSellersPage(),
            );
          },
        );
      //endregion

      case RouteName.notifications:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<NotificationsCubit>()..getNotifications(_)),
        ];
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: const NotificationsPage(),
            );
          },
        );
      //endregion

      case RouteName.searchResult:
        //region

        final providers = [
          BlocProvider(
            create: (_) => di.sl<SearchCubit>()
              ..getSearch(_, searchKey: (settings.arguments ?? '') as String),
          ),
        ];
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: const SearchResultPage(),
            );
          },
        );
      //endregion

      //endregion

      //region settings
      case RouteName.update:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<UpdateUserCubit>()),
        ];
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: UpdatePage(
                updateType: (settings.arguments ?? UpdateType.name) as UpdateType,
              ),
            );
          },
        );
      //endregion

      case RouteName.updateChoice:
        //region
        return MaterialPageRoute(
          builder: (context) {
            return const UpdateChoicePage();
          },
        );
      //endregion
      case RouteName.about:
        //region
        return MaterialPageRoute(
          builder: (context) {
            return const AboutPage();
          },
        );
      //endregion
      case RouteName.privacy:
        //region
        return MaterialPageRoute(
          builder: (context) {
            return const PrivacyPage();
          },
        );
      //endregion

      //endregion

      //region orders and cart

      case RouteName.myOrders:
        final providers = [
          BlocProvider(create: (_) => di.sl<OrdersCubit>()..getMyOrders(_)),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: const MyOrdersPage(),
            );
          },
        );

      //endregion

      //region product

      case RouteName.product:
        final providers = [
          BlocProvider(
            create: (context) => di.sl<ProductByIdCubit>()
              ..getProductById(context,
                  id: ((settings.arguments ?? Product.fromJson({})) as Product).id),
          ),
        ];
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: const ProductPage(),
            );
          },
        );

      //endregion

      //region category
      case RouteName.category:
        final category = (settings.arguments ?? Category.fromJson({})) as Category;
        final providers = [
          BlocProvider(
            create: (context) =>
                di.sl<CategoryByIdCubit>()..getCategory(context, category: category),
          ),
        ];
        return MaterialPageRoute(builder: (context) {
          return MultiBlocProvider(
            providers: providers,
            child: CategoriesPage(category: category),
          );
        });

      //endregion
    }

    return MaterialPageRoute(builder: (_) => const Scaffold(backgroundColor: Colors.red));
  }
}

class RouteName {
  static const splash = '/';
  static const welcomeScreen = '/1';
  static const home = '/2';
  static const forgetPassword = '/3';
  static const resetPasswordPage = '/4';
  static const login = '/5';
  static const signup = '/6';
  static const confirmCode = '/7';
  static const myAddress = '/8';
  static const product = '/9';
  static const profile = '/10';
  static const searchResult = '/11';
  static const update = '/12';
  static const updateChoice = '/13';
  static const notifications = '/14';
  static const offers = '/15';
  static const bestSeller = '/16';
  static const myOrders = '/17';
  static const about = '/18';
  static const privacy = '/19';
  static const category = '/20';
}
