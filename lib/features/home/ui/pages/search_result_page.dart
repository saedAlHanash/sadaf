import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/home/ui/widget/search_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../generated/assets.dart';
import '../../../product/ui/widget/item_product.dart';
import '../../bloc/search_cubit/search_cubit.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titleText: 'نتائج البحث'),
      body: Column(
        children: [
          const SearchFieldWidget(),
          BlocBuilder<SearchCubit, SearchInitial>(
            builder: (context, state) {
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              if (state.result.isEmpty) {
                return const Expanded(
                  child: NotFoundWidget(
                    icon: Assets.iconsNoSearch,
                    text:
                        'لم نتمكن من العثور على أي نتيجة لبحثك ، يرجى تجربة مصطلح بحث مختلف!',
                  ),
                );
              }
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.result.length,
                  itemBuilder: (_, i) {
                    return 0.0.verticalSpace;
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
