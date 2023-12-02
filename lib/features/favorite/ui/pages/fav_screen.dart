import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:sadaf/core/widgets/list_product_widget.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:sadaf/features/favorite/ui/widget/item_fav_widget.dart';
import 'package:sadaf/router/app_router.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/get_favorite/get_favorite_cubit.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarWidget(titleText: S.of(context).fav),
        BlocBuilder<FavoriteCubit, FavoriteInitial>(
          builder: (context, state) {
            return Expanded(
              child: ListView.separated(
                itemBuilder: (_, i) {
                  return ItemFavWidget();
                },
                separatorBuilder: (_, i) {
                  return 30.0.verticalSpace;
                },
                itemCount: 5,
              ),
            );
          },
        ),
      ],
    );
  }
}
