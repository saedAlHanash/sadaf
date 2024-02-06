import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  late final SubCategoriesCubit subCategoriesCubit;
  late final CategoriesCubit categoriesCubit;
  late final ProductsCubit productsCubit;

  @override
  void initState() {
    subCategoriesCubit = context.read<SubCategoriesCubit>();
    categoriesCubit = context.read<CategoriesCubit>();
    productsCubit = context.read<ProductsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CategoriesCubit, CategoriesInitial>(
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

                      productsCubit
                        ..setCategory = e.id
                        ..getProducts();
                    },
                  );
                },
              ),
            );
          },
        ),
        BlocBuilder<SubCategoriesCubit, SubCategoriesInitial>(
          builder: (context, state) {
            if (state.result.isEmpty) return 0.0.verticalSpace;
            return SizedBox(
              height: 70.0.h,
              width: 1.0.sw,
              child: ListView.builder(
                itemCount: state.result.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) {
                  return ItemSubCategoryImageWidget(
                    item: state.result[i],
                    singleLine: true,
                    selected: subCategoriesCubit.isSelected(state.result[i].id),
                    onTap: (e) {
                      if (subCategoriesCubit.isSelected(e.id)) return;
                      subCategoriesCubit.selectCategory(e.id);
                      productsCubit
                        ..setSubCategory = e.id
                        ..getProducts();
                    },
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
