import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sadaf/core/strings/enum_manager.dart';
import 'package:sadaf/features/home/ui/pages/search_result_page.dart';
import 'package:sadaf/features/notifications/ui/pages/notifications_page.dart';
import 'package:sadaf/features/orders/bloc/order_by_id_cubit/order_by_id_cubit.dart';
import 'package:sadaf/features/orders/ui/pages/tracking_order_page.dart';
import 'package:sadaf/features/product/bloc/products_cubit/products_cubit.dart';
import 'package:sadaf/features/product/data/response/products_response.dart';
import 'package:sadaf/features/product/ui/pages/product_page.dart';

import '../core/injection/injection_container.dart';
import '../core/widgets/web_view.dart';
import '../features/auth/bloc/confirm_code_cubit/confirm_code_cubit.dart';
import '../features/auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import '../features/auth/bloc/forget_password_cubit/forget_password_cubit.dart';
import '../features/auth/bloc/login_cubit/login_cubit.dart';
import '../features/auth/bloc/logout/logout_cubit.dart';
import '../features/auth/bloc/otp_password_cubit/otp_password_cubit.dart';
import '../features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import '../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../features/auth/bloc/signup_cubit/signup_cubit.dart';
import '../features/auth/ui/pages/confirm_code_page.dart';
import '../features/auth/ui/pages/done_page.dart';
import '../features/auth/ui/pages/forget_passowrd_page.dart';
import '../features/auth/ui/pages/login_page.dart';
import '../features/auth/ui/pages/otp_password_page.dart';
import '../features/auth/ui/pages/reset_password_page.dart';
import '../features/auth/ui/pages/signup_page.dart';
import '../features/auth/ui/pages/splash_screen_page.dart';
import '../features/categories/bloc/sub_categories_cubit/sub_categories_cubit.dart';
import '../features/categories/ui/pages/categories_page.dart';
import '../features/driver/bloc/driver_location_cubit/driver_location_cubit.dart';
import '../features/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import '../features/map/ui/pages/map_page.dart';
import '../features/orders/bloc/order_status_cubit/order_status_cubit.dart';
import '../features/product/ui/pages/products_page.dart';
import '../features/home/bloc/home_cubit/home_cubit.dart';
import '../features/home/bloc/search_cubit/search_cubit.dart';
import '../features/home/ui/pages/home_page.dart';
import '../features/map/bloc/my_location_cubit/my_location_cubit.dart';
import '../features/notifications/bloc/notifications_cubit/notifications_cubit.dart';
import '../features/offers/ui/pages/all_offers_page.dart';
import '../features/cart/bloc/create_order_cubit/create_order_cubit.dart';
import '../features/orders/bloc/orders_cubit/orders_cubit.dart';
import '../features/orders/data/response/orders_response.dart';
import '../features/orders/ui/pages/my_orders_page.dart';
import '../features/orders/ui/pages/order_page.dart';
import '../features/product/bloc/product_by_id_cubit/product_by_id_cubit.dart';
import '../features/product/bloc/select_option_cubit/select_option_cubit.dart';
import '../features/product/data/request/product_filter_request.dart';
import '../features/product/ui/pages/product_options_page.dart';
import '../features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';
import '../features/profile/ui/pages/my_info_page.dart';
import '../features/profile/ui/pages/update_choice_page.dart';
import '../features/profile/ui/pages/update_page.dart';
import '../features/settings/ui/pages/about_page.dart';
import '../features/settings/ui/pages/privacy_page.dart';

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
            builder: (_) {
              final providers = [
                BlocProvider(create: (_) => sl<SignupCubit>()),
              ];
              return MultiBlocProvider(
                providers: providers,
                child: const SignupPage(),
              );
            },
          );
        }
      //endregion
      case RouteName.login:
        //region
        {
          final providers = [
            BlocProvider(create: (_) => sl<LoginCubit>()),
          ];
          return MaterialPageRoute(
            builder: (_) {
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
            BlocProvider(create: (_) => sl<ForgetPasswordCubit>()),
          ];
          return MaterialPageRoute(
            builder: (_) {
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
            BlocProvider(create: (_) => sl<ResetPasswordCubit>()),
          ];
          return MaterialPageRoute(
            builder: (_) {
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
            BlocProvider(create: (_) => sl<ConfirmCodeCubit>()),
            BlocProvider(create: (_) => sl<ResendCodeCubit>()),
          ];
          return MaterialPageRoute(
            builder: (_) {
              return MultiBlocProvider(
                providers: providers,
                child: const ConfirmCodePage(),
              );
            },
          );
        }
      //endregion
      case RouteName.otpPassword:
        //region
        {
          final providers = [
            BlocProvider(create: (_) => sl<OtpPasswordCubit>()),
            BlocProvider(create: (_) => sl<ResendCodeCubit>()),
          ];
          return MaterialPageRoute(
            builder: (_) {
              return MultiBlocProvider(
                providers: providers,
                child: const OtpPasswordPage(),
              );
            },
          );
        }
      //endregion

      case RouteName.donePage:
        //region
        {
          return MaterialPageRoute(
            builder: (_) {
              return DonePage(params: settings.arguments as DonePageParams);
            },
          );
        }
      //endregion
      //endregion

      //region home
      case RouteName.home:
        //region

        final providers = [
          BlocProvider(create: (_) => sl<HomeCubit>()..getHome(_)),
          BlocProvider(create: (_) => sl<LogoutCubit>()),
          BlocProvider(create: (_) => sl<DeleteAccountCubit>()),
          BlocProvider(create: (_) => sl<CreateOrderCubit>()),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: const Homepage(),
            );
          },
        );
      //endregion

      case RouteName.offers:
        //region

        return MaterialPageRoute(
          builder: (_) {
            return AllOffersPage(index: (settings.arguments ?? 0) as int);
          },
        );
      //endregion

      case RouteName.notifications:
        //region

        final providers = [
          BlocProvider(create: (_) => sl<NotificationsCubit>()..getNotifications(_)),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: const NotificationsPage(),
            );
          },
        );
      //endregion
      //
      // case RouteName.searchResult:
      //   //region
      //
      //   final providers = [
      //     BlocProvider(
      //       create: (_) => sl<SearchCubit>()
      //         ..getSearch(_, searchKey: (settings.arguments ?? '') as String),
      //     ),
      //   ];
      //   return MaterialPageRoute(
      //     builder: (_) {
      //       return MultiBlocProvider(
      //         providers: providers,
      //         child: const SearchResultPage(),
      //       );
      //     },
      //   );
      // //endregion

      //endregion

      //region settings

      case RouteName.update:
        //region

        final providers = [
          BlocProvider(create: (_) => sl<UpdateProfileCubit>()),
          BlocProvider(create: (_) => sl<MyLocationCubit>()),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: UpdatePage(
                updateType: (settings.arguments ?? UpdateType.name) as UpdateType,
              ),
            );
          },
        );
      //endregion

      case RouteName.map:
        //region

        return MaterialPageRoute(
          builder: (_) {
            return MapPage(
              initial: (settings.arguments ?? initialLocation) as LatLng,
            );
          },
        );
      //endregion

      case RouteName.myInfo:
        //region

        return MaterialPageRoute(
          builder: (_) {
            return const MyInfoPage();
          },
        );
      //endregion

      case RouteName.updateChoice:
        //region
        return MaterialPageRoute(
          builder: (_) {
            return const UpdateChoicePage();
          },
        );
      //endregion

      case RouteName.about:
        //region
        return MaterialPageRoute(
          builder: (_) {
            return const AboutPage();
          },
        );
      //endregion

      case RouteName.privacy:
        //region
        return MaterialPageRoute(
          builder: (_) {
            return const PrivacyPage();
          },
        );
      //endregion

      //endregion

      //region orders and cart

      case RouteName.myOrders:
        //region
        final providers = [
          BlocProvider(create: (_) => sl<OrdersCubit>()..getOrders()),
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

      case RouteName.orderInfo:
        //region
        final providers = [
          BlocProvider(
            create: (_) => sl<OrderByIdCubit>()
              ..getOrderById(
                  id: ((settings.arguments ?? Order.fromJson({})) as Order).id),
          ),
          BlocProvider(
            create: (_) => sl<OrderStatusCubit>()
              ..getOrderStatus(
                  id: ((settings.arguments ?? Order.fromJson({})) as Order).id),
          ),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: const OrderPage(),
            );
          },
        );

      //endregion

      case RouteName.trackingOrder:
        //region
        final providers = [
          BlocProvider(
            create: (_) => sl<OrderByIdCubit>()
              ..getOrderById(
                  id: ((settings.arguments ?? Order.fromJson({})) as Order).id),
          ),
          BlocProvider(create: (_) => sl<DriverLocationCubit>()),
          BlocProvider(create: (_) => sl<MapControllerCubit>()),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: const TrackingOrderPage(),
            );
          },
        );

      //endregion

      //endregion

      //region product

      case RouteName.product:
        //region
        final providers = [
          BlocProvider(
            create: (_) => sl<ProductByIdCubit>()
              ..getProductById(id: (settings.arguments ?? 0) as int),
          ),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: const ProductPage(),
            );
          },
        );

      //endregion

      case RouteName.productOptions:
        final product = ((settings.arguments ?? Product.fromJson({})) as Product);
        //region
        final providers = [
          BlocProvider(create: (_) => sl<SelectOptionCubit>()..setProduct(product))
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: ProductOptionsPage(product: product),
            );
          },
        );

      //endregion

      //endregion

      //region product

      case RouteName.products:
        final request = (settings.arguments ?? ProductFilterRequest.fromJson({}))
            as ProductFilterRequest;
        final providers = [
          BlocProvider(
            create: (_) => sl<ProductsCubit>()..getProducts(request: request),
          ),
          if ((request.categoryId ?? 0) != 0)
            BlocProvider(
              create: (_) =>
                  sl<SubCategoriesCubit>()..getSubCategories(subId: request.categoryId),
            ),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: const ProductsPage(),
            );
          },
        );

      //endregion

      //region category
      case RouteName.category:
        return MaterialPageRoute(builder: (_) {
          return CategoriesPage();
        });

      //endregion

      //region webView
      case RouteName.webView:
        return MaterialPageRoute(
          builder: (_) => WebViewExample(url: settings.arguments as String),
        );

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

  static const product = '/9';
  static const myInfo = '/10';

  // static const searchResult = '/11';
  static const update = '/12';
  static const updateChoice = '/13';
  static const notifications = '/14';
  static const offers = '/15';
  static const bestSeller = '/16';
  static const myOrders = '/17';
  static const about = '/18';
  static const privacy = '/19';
  static const category = '/20';
  static const otpPassword = '/21';
  static const donePage = '/22';
  static const products = '/23';
  static const orderInfo = '/24';
  static const productOptions = '/25';
  static const webView = '/26';
  static const trackingOrder = '/27';
  static const map = '/28';
}
