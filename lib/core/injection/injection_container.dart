import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/bloc/confirm_code_cubit/confirm_code_cubit.dart';
import '../../features/auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import '../../features/auth/bloc/forget_password_cubit/forget_password_cubit.dart';
import '../../features/auth/bloc/get_me_cubit/get_me_cubit.dart';
import '../../features/auth/bloc/login_cubit/login_cubit.dart';
import '../../features/auth/bloc/logout/logout_cubit.dart';
import '../../features/auth/bloc/otp_password_cubit/otp_password_cubit.dart';
import '../../features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import '../../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../../features/auth/bloc/signup_cubit/signup_cubit.dart';
import '../../features/cart/bloc/add_to_cart_cubit/add_to_cart_cubit.dart';
import '../../features/cart/bloc/clear_cart_cubit/clear_cart_cubit.dart';
import '../../features/cart/bloc/coupon_cubit/coupon_cubit.dart';
import '../../features/cart/bloc/decrease_cubit/decrease_cubit.dart';
import '../../features/cart/bloc/get_cart_cubit/get_cart_cubit.dart';
import '../../features/cart/bloc/increase_cubit/increase_cubit.dart';
import '../../features/cart/bloc/remove_from_cart_cubit/remove_from_cart_cubit.dart';
import '../../features/categories/bloc/categories_cubit/categories_cubit.dart';
import '../../features/categories/bloc/sub_categories_cubit/sub_categories_cubit.dart';
import '../../features/chat/bloc/add_message_cubit/add_message_cubit.dart';
import '../../features/chat/bloc/chat_messages_cubit/chat_messages_cubit.dart';
import '../../features/colors/bloc/colors_cubit/colors_cubit.dart';
import '../../features/driver/bloc/driver_location_cubit/driver_location_cubit.dart';
import '../../features/favorite/bloc/add_favorite/add_favorite_cubit.dart';
import '../../features/favorite/bloc/get_favorite/get_favorite_cubit.dart';
import '../../features/firebase/bloc/insert_firebase_token_cubit/insert_firebase_token_cubit.dart';
import '../../features/flash_deal/bloc/flash_deal_cubit/flash_deal_cubit.dart';
import '../../features/governors/bloc/governors_cubit/governors_cubit.dart';
import '../../features/home/bloc/banner_cubit/banner_cubit.dart';
import '../../features/home/bloc/home_cubit/home_cubit.dart';
import '../../features/home/bloc/search_cubit/search_cubit.dart';
import '../../features/home/bloc/slider_cubit/slider_cubit.dart';
import '../../features/manufacturers/bloc/manufacturerss_cubit/manufacturers_cubit.dart';
import '../../features/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import '../../features/map/bloc/my_location_cubit/my_location_cubit.dart';
import '../../features/notifications/bloc/notification_count_cubit/notification_count_cubit.dart';
import '../../features/notifications/bloc/notifications_cubit/notifications_cubit.dart';
import '../../features/offers/bloc/offers_cubit/offers_cubit.dart';
import '../../features/cart/bloc/create_order_cubit/create_order_cubit.dart';
import '../../features/orders/bloc/order_by_id_cubit/order_by_id_cubit.dart';
import '../../features/orders/bloc/order_status_cubit/order_status_cubit.dart';
import '../../features/orders/bloc/orders_cubit/orders_cubit.dart';
import '../../features/product/bloc/new_arrival_cubit/new_arrival_cubit.dart';
import '../../features/product/bloc/product_by_id_cubit/product_by_id_cubit.dart';
import '../../features/product/bloc/products_cubit/products_cubit.dart';
import '../../features/product/bloc/select_option_cubit/select_option_cubit.dart';
import '../../features/profile/bloc/profile_cubit/profile_cubit.dart';
import '../../features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';
import '../../features/settings/services/setting_service.dart';
import '../app/bloc/loading_cubit.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //region Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerFactory(() => NotificationCountCubit());
  sl.registerFactory(() => MyLocationCubit());
  sl.registerLazySingleton(() => LoadingCubit());
  sl.registerLazySingleton(() => SettingService());
  sl.registerLazySingleton(() => InsertFirebaseTokenCubit());
  sl.registerLazySingleton(() => GlobalKey<NavigatorState>());

  //endregion

  //region auth
  sl.registerFactory(() => SignupCubit());
  sl.registerFactory(() => LoginCubit());
  sl.registerFactory(() => ForgetPasswordCubit());
  sl.registerFactory(() => ResetPasswordCubit());
  sl.registerFactory(() => GetMeCubit());
  sl.registerFactory(() => ConfirmCodeCubit());
  sl.registerFactory(() => ResendCodeCubit());
  sl.registerFactory(() => DeleteAccountCubit());
  sl.registerFactory(() => OtpPasswordCubit());

  //endregion

  // region profile
  sl.registerFactory(() => UpdateProfileCubit());
  //endregion

  //region home
  sl.registerFactory(() => HomeCubit());
  sl.registerFactory(() => SliderCubit());
  sl.registerFactory(() => BannerCubit());
  sl.registerFactory(() => SearchCubit());
  sl.registerFactory(() => LogoutCubit());
  sl.registerFactory(() => ProfileCubit());
  sl.registerFactory(() => NotificationsCubit());

  //endregion

  //region offers
  sl.registerFactory(() => OffersCubit());
  sl.registerFactory(() => FlashDealsCubit());

  //endregion

  //region BestSeller

  //endregion

  //region fav

  sl.registerFactory(() => AddFavoriteCubit());
  sl.registerFactory(() => FavoriteCubit());

  //endregion

  //region Cart

  sl.registerLazySingleton(() => CartCubit());

  sl.registerLazySingleton(() => DecreaseCubit());
  sl.registerLazySingleton(() => IncreaseCubit());

  sl.registerFactory(() => AddToCartCubit());
  sl.registerFactory(() => RemoveFromCartCubit());
  sl.registerFactory(() => ClearCartCubit());
  sl.registerFactory(() => CouponCubit());

  //endregion

  //region category

  sl.registerFactory(() => CategoriesCubit());
  sl.registerFactory(() => SubCategoriesCubit());

  //endregion

  //region Governors

  sl.registerFactory<GovernorsCubit>(() => GovernorsCubit());

  //endregion

  //region product
  sl.registerFactory(() => ProductByIdCubit());
  sl.registerFactory(() => ProductsCubit());
  sl.registerFactory(() => NewArrivalProductsCubit());

  //endregion

  //region colors
  sl.registerFactory(() => ColorsCubit());

  //endregion

  //region chat
  sl.registerFactory(() => MessagesCubit());
  sl.registerFactory(() => AddMessageCubit());

  //endregion

  //region manufacturers
  sl.registerFactory(() => ManufacturersCubit());

  //endregion

  //region order
  sl.registerFactory(() => CreateOrderCubit());
  sl.registerFactory(() => OrdersCubit());
  sl.registerFactory(() => OrderByIdCubit());
  sl.registerFactory(() => OrderStatusCubit());
  sl.registerFactory(() => DriverLocationCubit());
  sl.registerFactory(() => MapControllerCubit());

  //endregion

  sl.registerFactory(() => SelectOptionCubit());
//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
