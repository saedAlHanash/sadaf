// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sadaf/core/api_manager/api_url.dart';
// import 'package:sadaf/features/cart/service/cart_service.dart';
// import 'package:sadaf/features/orders/data/request/create_order_request.dart';
//
// import '../../../../core/api_manager/api_service.dart';
// import '../../../../core/error/error_manager.dart';
// import '../../../../core/injection/injection_container.dart';
// import '../../../../core/network/network_info.dart';
// import '../../../../core/strings/enum_manager.dart';
// import '../../../../core/util/pair_class.dart';
// import '../../../../core/util/snack_bar_message.dart';
// import '../../../../generated/l10n.dart';
// import '../update_cart_cubit/update_cart_cubit.dart';
//
// part 'create_order_state.dart';
//
// class CreateOrderCubit extends Cubit<CreateOrderInitial> {
//   CreateOrderCubit() : super(CreateOrderInitial.initial());
//
//
//
//   Future<void> createOrder(BuildContext context,
//       {required CreateOrderRequest request}) async {
//     emit(state.copyWith(statuses: CubitStatuses.loading));
//     final pair = await _createOrderApi(request: request);
//     if (context.mounted) {
//       context.read<UpdateCartCubit>().updateCart();
//     }
//
//     if (pair.first == null) {
//       if (context.mounted) {
//         NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
//       }
//       emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
//     } else {
//       emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
//     }
//   }
//
//   Future<Pair<bool?, String?>> _createOrderApi(
//       {required CreateOrderRequest request}) async {
//
//       final response = await APIService().postApi(
//         url: PostUrl.createOrder,
//         body: request.toMap(),
//       );
//
//       if (response.statusCode == 200) {
//         sl<CartService>().cleanCart();
//         return Pair(true, null);
//       } else {
//       return response.getPairError;
//       }
//
//   }
// }
