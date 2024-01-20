import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/api_manager/api_service.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/features/categories/ui/pages/categories_page.dart';
import 'package:sadaf/features/home/ui/widget/search_widget.dart';
import 'package:sadaf/features/product/ui/widget/item_product.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../../product/bloc/products_cubit/products_cubit.dart';
import '../../bloc/categories_cubit/categories_cubit.dart';
import '../../bloc/sub_categories_cubit/sub_categories_cubit.dart';
import '../widget/item_category_image.dart';

class ListCategoriesFilter extends StatefulWidget {
  const ListCategoriesFilter({super.key});

  @override
  State<ListCategoriesFilter> createState() => _ListCategoriesFilterState();
}

class _ListCategoriesFilterState extends State<ListCategoriesFilter> {
  late final SubCategoriesCubit categoriesCubit;
  late final ProductsCubit productsCubit;

  @override
  void initState() {
    categoriesCubit = context.read<SubCategoriesCubit>();
    productsCubit = context.read<ProductsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubCategoriesCubit, SubCategoriesInitial>(
      builder: (context, state) {
        if (state.result.isEmpty) return 0.0.verticalSpace;
        return SizedBox(
          height: 70.0.h,
          width: 1.0.sw,
          child: ListView.builder(
            itemCount: state.result.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) {
              return ItemCategoryImageWidget(
                item: state.result[i],
                singleLine: true,
                selected: categoriesCubit.isSelected(state.result[i].id),
                onTap: (e) {
                  if (categoriesCubit.isSelected(e.id)) return;
                  categoriesCubit.selectCategory(e.id);
                  productsCubit.getProducts(
                    request: productsCubit.state.request.copyWith(
                      categoryId: e.id,
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
