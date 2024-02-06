import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/core/strings/enum_manager.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/core/widgets/my_button.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../product/bloc/add_review_cubit/add_review_cubit.dart';
import '../../../product/data/request/add_review_request.dart';
import '../../../product/data/response/products_response.dart';
import '../../../product/ui/widget/item_product.dart';
import '../../bloc/order_by_id_cubit/order_by_id_cubit.dart';
import '../../bloc/order_status_cubit/order_status_cubit.dart';
import '../../data/response/orders_response.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddReviewCubit, AddReviewInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        context.read<OrderByIdCubit>().getOrderById(id: state.request.orderId);
      },
      child: Scaffold(
        appBar: AppBarWidget(
          title: BlocBuilder<OrderByIdCubit, OrderByIdInitial>(
            builder: (context, state) {
              if (state.statuses.loading) {
                return 0.0.verticalSpace;
              }
              return DrawableText(
                text: '#${state.result.id}',
                size: 28.0.spMin,
              );
            },
          ),
          actions: [
            Center(
              child: BlocBuilder<OrderByIdCubit, OrderByIdInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return 0.0.verticalSpace;
                  }
                  return DrawableText(
                    text: state.result.status,
                    color: state.result.statusEnum.getOrderStateColorText,
                    padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
                  );
                },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<OrderByIdCubit, OrderByIdInitial>(
            builder: (context, state) {
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              return Column(
                children: [
                  for (var e in state.result.products) ItemOrderProduct(product: e),
                  if (state.result.couponCode.isNotEmpty)
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0).r,
                      child: MyTextFormOutLineWidget(
                        label: S.of(context).coupon_code,
                        innerPadding: const EdgeInsets.symmetric(horizontal: 10.0).w,
                        enable: false,
                        initialValue: state.result.couponCode,
                      ),
                    ),
                  20.0.verticalSpace,
                  Container(
                    color: AppColorManager.f8,
                    padding: const EdgeInsets.all(30.0).r,
                    child: Column(
                      children: [
                        DrawableText(
                          size: 16.0.sp,
                          text: S.of(context).order_summary.toUpperCase(),
                          matchParent: true,
                          color: AppColorManager.c50,
                          drawableAlin: DrawableAlin.between,
                          drawableEnd: DrawableText(
                            size: 16.0.sp,
                            text: state.result.total,
                            color: AppColorManager.c50,
                          ),
                        ),
                        15.0.verticalSpace,
                        DrawableText(
                          size: 16.0.sp,
                          text: S.of(context).additional_service.toUpperCase(),
                          matchParent: true,
                          color: AppColorManager.c50,
                          drawableAlin: DrawableAlin.between,
                          drawableEnd: DrawableText(
                            size: 16.0.sp,
                            text: '0',
                            color: AppColorManager.c50,
                          ),
                        ),
                        const Divider(),
                        DrawableText(
                          size: 20.0.sp,
                          text: S.of(context).subtotal.toUpperCase(),
                          matchParent: true,
                          color: AppColorManager.c50,
                          drawableAlin: DrawableAlin.between,
                          drawableEnd: DrawableText(
                            size: 20.0.sp,
                            text: state.result.subtotal,
                            color: AppColorManager.c50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.0.verticalSpace,
                  if (state.result.statusEnum == OrderStatus.completed)
                    Builder(builder: (context) {
                      final canRate = state.result.products.firstWhereOrNull(
                            (e) => !e.isReviewed,
                          ) !=
                          null;
                      return MyButton(
                        onTap: () {
                          NoteMessage.showBottomSheet1(
                            context,
                            _OrderReview(order: state.result),
                          );
                        },
                        enable: canRate,
                        child: DrawableText(
                          text: canRate ? S.of(context).addReview : S.of(context).rated,
                          color: Colors.white,
                          drawablePadding: 10.0.w,
                          drawableEnd: ImageMultiType(
                            url: canRate ? Assets.iconsFullStar : Icons.check,
                            color: Colors.white,
                            height: 25.0.r,
                            width: 25.0.r,
                          ),
                        ),
                      );
                    }),
                  20.0.verticalSpace,
                  BlocBuilder<OrderStatusCubit, OrderStatusInitial>(
                    builder: (context, state) {
                      if (state.statuses.loading) {
                        return MyStyle.loadingWidget();
                      }
                      return const Column(
                        children: [
                          _ItemDateOrderRed(state: OrderStatus.canceled),
                          _ItemDateOrderRed(state: OrderStatus.paymentFailed),
                          _ItemDateOrderRed(state: OrderStatus.returned),
                          // _ItemDateOrder(state: OrderStatus.pending),
                          _ItemDateOrder(state: OrderStatus.processing),
                          _ItemDateOrder(state: OrderStatus.ready),
                          _ItemDateOrder(state: OrderStatus.shipping),
                          _ItemDateOrder(state: OrderStatus.completed),
                        ],
                      );
                    },
                  ),
                  40.0.verticalSpace,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ItemDateOrder extends StatelessWidget {
  const _ItemDateOrder({required this.state});

  final OrderStatus state;

  @override
  Widget build(BuildContext context) {
    final date = context.read<OrderStatusCubit>().state.getDate(state);
    return DrawableText(
      size: 18.0.sp,
      padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 30.0).r,
      text: state.getNameDateOrderStatus,
      matchParent: true,
      color: date == null ? AppColorManager.lightGrayEd : AppColorManager.mainColor,
      drawableAlin: DrawableAlin.between,
      drawableEnd: DrawableText(
        size: 14.0.sp,
        textAlign: TextAlign.center,
        text: date == null
            ? S.of(context).notYet
            : '${date.formatDate}\n${date.formatTime}',
        color: date == null ? AppColorManager.lightGrayEd : AppColorManager.c6e,
      ),
    );
  }
}

class _ItemDateOrderRed extends StatelessWidget {
  const _ItemDateOrderRed({required this.state});

  final OrderStatus state;

  @override
  Widget build(BuildContext context) {
    final date = context.read<OrderStatusCubit>().state.getDate(state);
    if (date == null) return 0.0.verticalSpace;
    return DrawableText(
      size: 18.0.sp,
      padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 30.0).r,
      text: state.getNameDateOrderStatus,
      matchParent: true,
      color: Colors.red,
      drawableAlin: DrawableAlin.between,
      drawableEnd: DrawableText(
        size: 14.0.sp,
        textAlign: TextAlign.center,
        text: '${date.formatDate}\n${date.formatTime}',
        color: Colors.red,
      ),
    );
  }
}

class _OrderReview extends StatefulWidget {
  const _OrderReview({super.key, required this.order});

  final Order order;

  @override
  State<_OrderReview> createState() => _OrderReviewState();
}

class _OrderReviewState extends State<_OrderReview> {
  final list = <Product>[];

  @override
  void initState() {
    list.addAll(widget.order.products.where((e) => !e.isReviewed));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 1.0.sw, maxHeight: .6.sh),
      child: Column(
        children: [
          20.0.verticalSpace,
          DrawableText(text: S.of(context).setReview),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
              itemBuilder: (context, i) {
                final item = list[i];
                return Container(
                  width: 1.0.sw,
                  height: 75.0.h,
                  margin: const EdgeInsets.symmetric(vertical: 15.0).h,
                  child: Row(
                    children: [
                      ImageMultiType(
                        url: item.thumbnail,
                        height: 54.0.r,
                        width: 54.0.r,
                      ),
                      20.0.horizontalSpace,
                      Expanded(
                        child: DrawableText(
                          size: 14.0.sp,
                          text: item.name,
                          maxLines: 2,
                          fontFamily: FontManager.cairoBold.name,
                        ),
                      ),
                      20.0.horizontalSpace,
                      RatingBar(
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 5.0).w,
                        ratingWidget: RatingWidget(
                          full: ImageMultiType(url: Assets.iconsFullStar, width: 14.0.r),
                          half: ImageMultiType(url: Assets.iconsFullStar, width: 14.0.r),
                          empty:
                              ImageMultiType(url: Assets.iconsEmptyStar, width: 14.0.r),
                        ),
                        initialRating: item.localRate,
                        itemSize: 18.0.r,
                        onRatingUpdate: (value) => item.localRate = value,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          BlocConsumer<AddReviewCubit, AddReviewInitial>(
            listenWhen: (p, c) => c.statuses.done,
            listener: (_, state) {
              Navigator.pop(context, true);
            },
            builder: (_, state) {
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              return MyButton(
                text: S.of(context).confirm,
                onTap: () {
                  context.read<AddReviewCubit>().addReview(
                        request: AddReviewRequest.fromProducts(
                          widget.order.products,
                          widget.order.id,
                        ),
                      );
                },
              );
            },
          ),
          20.0.verticalSpace,
        ],
      ),
    );
  }
}
