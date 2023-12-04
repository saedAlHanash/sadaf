import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/product/data/response/products_response.dart';
import 'package:sadaf/generated/assets.dart';

import '../../../../core/util/my_style.dart';
import '../../bloc/add_favorite/add_favorite_cubit.dart';

class FavBtnWidget extends StatelessWidget {
  const FavBtnWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0.r,
      width: 50.0.r,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10.0).r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.5),
      ),
      child: BlocBuilder<AddFavoriteCubit, AddFavoriteInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          return InkWell(
            onTap: () {
              context.read<AddFavoriteCubit>().addFavorite(product: product);
            },
            child: ImageMultiType(
              url: Assets.iconsFav,
              color: product.isFavorite ? Colors.black : null,
            ),
          );
        },
      ),
    );
  }
}
