import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/core/util/my_style.dart';
import 'package:sadaf/core/widgets/not_found_widget.dart';

import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/my_expansion/item_expansion.dart';
import '../../../../core/widgets/my_expansion/my_expansion_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/faq_cubit/faq_cubit.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).faq),
      body: BlocBuilder<FaqCubit, FaqInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          if (state.result.isEmpty) {
            return const NotFoundWidget(
              text: 'No Data',
              icon: Assets.iconsNoSearchResult,
            );
          }
          return SingleChildScrollView(
            child: MyExpansionWidget(
              elevation: 0.0,
              items: state.result
                  .mapIndexed(
                    (i, e) => ItemExpansion(
                      header: Column(
                        children: [
                          if (i != 0) Divider(),
                          DrawableText(
                            text: e.title,
                            matchParent: true,
                            drawableEnd: Padding(
                              padding: EdgeInsetsDirectional.only(end: 30.0.w),
                              child: const ImageMultiType(
                                url: Icons.keyboard_arrow_down_sharp,
                              ),
                            ),
                            drawableStart: DrawableText(
                              text: '${e.id < 10 ? '0${e.id}' : e.id}',
                              size: 32.0.sp,
                              padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
                            ),
                          ),
                        ],
                      ),
                      body: Padding(
                        padding: EdgeInsetsDirectional.only(start: 93.0.w),
                        child: DrawableText(
                          text: e.body,
                          color: AppColorManager.c8f,
                          fontFamily: FontManager.cairoSemiBold.name,
                          matchParent: true,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
