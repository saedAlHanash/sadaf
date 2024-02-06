import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/favorite/ui/widget/item_fav_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/add_favorite/add_favorite_cubit.dart';
import '../../bloc/get_favorite/get_favorite_cubit.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  void initState() {
    context.read<FavoriteCubit>().getFavorite(withLoading: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddFavoriteCubit, AddFavoriteInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        context.read<FavoriteCubit>().getFavorite(withLoading: false);
      },
      child: Column(
        children: [
          AppBarWidget(titleText: S.of(context).fav),
          BlocBuilder<FavoriteCubit, FavoriteInitial>(
            builder: (context, state) {
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              if (state.result.isEmpty) {
                return Expanded(
                  child: NotFoundWidget(
                    text: S.of(context).emptyFav,
                    icon: Assets.iconsNoFavResult,
                  ),
                );
              }
              return Expanded(
                child: ListView.separated(
                  itemBuilder: (_, i) {
                    return ItemFavWidget(fav: state.result[i]);
                  },
                  separatorBuilder: (_, i) {
                    return 30.0.verticalSpace;
                  },
                  itemCount: state.result.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
