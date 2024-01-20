import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/api_manager/api_service.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/core/widgets/not_found_widget.dart';
import 'package:sadaf/features/categories/ui/pages/categories_page.dart';
import 'package:sadaf/features/categories/ui/widget/list_categories_filter.dart';
import 'package:sadaf/features/home/ui/widget/search_widget.dart';
import 'package:sadaf/features/product/ui/widget/item_product.dart';
import 'package:sadaf/generated/assets.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/products_cubit/products_cubit.dart';
import '../../../categories/bloc/categories_cubit/categories_cubit.dart';
import '../../../categories/bloc/sub_categories_cubit/sub_categories_cubit.dart';
import '../../../categories/ui/widget/item_category_image.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late final CategoriesCubit categoriesCubit;
  late final ProductsCubit productsCubit;

  @override
  void initState() {
    categoriesCubit = context.read<CategoriesCubit>();
    productsCubit = context.read<ProductsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        titleText: S.of(context).related_products,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
        child: Column(
          children: [
            BlocBuilder<ProductsCubit, ProductsInitial>(
              buildWhen: (p, c) => c.statuses.done,
              builder: (context, state) {
                return SearchProductsFieldWidget(
                  onApply: (val) {
                    if (productsCubit.state.request.search == val) return;
                    productsCubit.getProducts(
                      request: productsCubit.state.request.copyWith(search: val),
                    );
                  },
                  initialVal: state.request.search,
                );
              },
            ),
            20.0.verticalSpace,
            const ListCategoriesFilter(),
            20.0.verticalSpace,
            Expanded(
              child: BlocBuilder<ProductsCubit, ProductsInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  final list = state.result;

                  if (list.isEmpty) {
                    return NotFoundWidget(
                      text: S.of(context).emptySearch,
                      icon: Assets.iconsNoSearchResult,
                    );
                  }
                  return ListView.separated(
                    itemCount: list.length.countDiv2,
                    padding:
                        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0).r,
                    separatorBuilder: (_, i) {
                      return 20.0.verticalSpace;
                    },
                    itemBuilder: (_, i) {
                      return Row(
                        children: [
                          ItemProduct(product: list[i]),
                          35.0.horizontalSpace,
                          if (i + 1 < list.length) ItemProduct(product: list[i + 1]),
                        ],
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
