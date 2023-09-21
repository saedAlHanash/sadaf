import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:sadaf/features/home/data/response/home_response.dart';
import '../../features/favorite/bloc/add_favorite/add_favorite_cubit.dart';
import '../../features/favorite/bloc/get_favorite/get_favorite_cubit.dart';
import '../../features/product/data/models/product.dart';
import '../../generated/assets.dart';
import '../strings/enum_manager.dart';
import '../util/my_style.dart';
import 'images/image_multi_type.dart';

class FavBtnWidget extends StatefulWidget {
  const FavBtnWidget({
    Key? key,
    required this.product,
    this.onChangeFav,
  }) : super(key: key);

  final Product product;
  final Function(bool)? onChangeFav;

  @override
  State<FavBtnWidget> createState() => _FavBtnWidgetState();
}

class _FavBtnWidgetState extends State<FavBtnWidget> {
  bool isFav = false;
  bool enable = true;

  @override
  void initState() {
    isFav = widget.product.isFav;
    if (isFav && !FavoriteCubit.favIds.contains(widget.product.id)) {
      isFav = false;
      widget.product.isFav = false;
    }
    super.initState();
  }

  void listenFavSend(CubitStatuses state) {
    switch (state) {
      case CubitStatuses.init:
      case CubitStatuses.done:
        context.read<FavoriteCubit>().getFavorite(context);
        if (widget.onChangeFav != null) {
          widget.onChangeFav!(isFav);
        }

        break;
      case CubitStatuses.loading:
        setState(() => isFav = !isFav);
        break;

      case CubitStatuses.error:
        setState(() => isFav = widget.product.isFav);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!AppSharedPreference.isLogin) return 0.0.verticalSpace;
    return MultiBlocListener(
      listeners: [
        BlocListener<AddFavoriteCubit, AddFavoriteInitial>(
          listener: (_, state) {
            state.statuses.loading ? enable = false : enable = true;

            if (state.product.id == widget.product.id) {
              listenFavSend(state.statuses);
            }
          },
        ),
      ],
      child: IconButton(
        onPressed: () {
          if (!enable) return;
          context
              .read<AddFavoriteCubit>()
              .addFavorite(context, product: widget.product, isFav: isFav);
        },
        icon: BlocBuilder<AddFavoriteCubit, AddFavoriteInitial>(
          buildWhen: (previous, c) => c.product.id == widget.product.id,
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            return ImageMultiType(
              url: isFav ? Assets.iconsFavHart : Assets.iconsEmptyHart,
              height: 18.0.r,
              width: 18.0.r,
            );
          },
        ),
      ),
    );
  }
}
