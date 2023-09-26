import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/core/widgets/not_found_widget.dart';
import 'package:slide_action/slide_action.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../../home/ui/widget/item_category.dart';
import '../../../home/ui/widget/search_widget.dart';
import '../../../product/ui/widget/item_product.dart';
import '../../bloc/category_by_id_cubit/category_by_id_cubit.dart';
import '../../data/models/category.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: category.name),
      body: Column(
        children: [
          const TopSearchBar(),
          Expanded(
            child: BlocBuilder<CategoryByIdCubit, CategoryByIdInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //التصنيفات
                    FutureBuilder(
                        future: CategoryByIdCubit.getSubCategoryApi(
                          id: category.id,
                          isSub: category.isSub,
                        ),
                        builder: (context, snapShot) {
                          if (!snapShot.hasData) {
                            return MyStyle.loadingWidget();
                          }
                          final list = snapShot.data!;

                          if (list.isEmpty) return const SizedBox.shrink();

                          list.forEachIndexed((i, e) => e.isSub = true);

                          return SizedBox(
                            height: 120.0.h,
                            child: ListView.separated(
                              itemCount: list.length,
                              padding: const EdgeInsets.symmetric(horizontal: 12.0).w,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, i) {
                                final item = list[i];
                                return ItemCategory(category: item);
                              },
                              separatorBuilder: (_, i) => 12.0.horizontalSpace,
                            ),
                          );
                        }),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          if (state.result.isEmpty) {
                            return const NotFoundWidget(
                                text: 'لا يوجد منتجات', icon: Assets.iconsNotFound);
                          }
                          return GridView.builder(
                            shrinkWrap: true,
                            itemCount: state.result.length,
                            itemBuilder: (_, i) {
                              return ItemProduct(product: state.result[i]);
                            },
                            gridDelegate: MyStyle.productGridDelegate,
                          );
                        }
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SlideActionBtn extends StatelessWidget {
  const SlideActionBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: SlideAction(
        trackBuilder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Center(
              child: Text(
                // Show loading if async operation is being performed
                state.isPerformingAction ? "Loading..." : "Slide to logout",
              ),
            ),
          );
        },
        thumbBuilder: (context, state) {
          return Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              // Show loading indicator if async operation is being performed
              child: state.isPerformingAction
                  ? const CupertinoActivityIndicator(
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
            ),
          );
        },
        action: () async {
          // Async operation
          await Future.delayed(
            const Duration(seconds: 2),
            () => debugPrint("action completed"),
          );
        },
      ),
    );
  }
}
