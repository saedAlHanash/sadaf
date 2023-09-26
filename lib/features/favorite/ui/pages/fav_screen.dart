import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:sadaf/core/widgets/list_product_widget.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:sadaf/router/app_router.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../generated/assets.dart';
import '../../bloc/get_favorite/get_favorite_cubit.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    if (!AppSharedPreference.isLogin) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const NotFoundWidget(
            text: 'يجب تسجبل الدخول لرؤية المفضلة',
            icon: Assets.iconsNoFav,
          ),
          MyButton(
            text: 'تسجيل الدخول ؟',
            onTap: () => Navigator.pushNamed(context, RouteName.login),
          )
        ],
      );
    }
    context.read<FavoriteCubit>().getFavorite(context);

    return Column(
      children: [
        SizedBox(
          width: 1.0.sw,
        ),
        const AppBarWidget(titleText: 'المفضلة'),
        BlocBuilder<FavoriteCubit, FavoriteInitial>(
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            if (state.result.isEmpty) {
              return const NotFoundWidget(
                icon: Assets.iconsNoFav,
                text: 'لا يوجد منتجات مفضلة',
              );
            }
            return ListProductWidget(products: state.result);
          },
        ),
      ],
    );
  }
}
