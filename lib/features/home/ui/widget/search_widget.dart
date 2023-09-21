import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/util/shared_preferences.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/images/image_multi_type.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../router/app_router.dart';
import '../../../notifications/bloc/notification_count_cubit/notification_count_cubit.dart';

class TopSearchBar extends StatelessWidget {
  const TopSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0).r,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Expanded(
            child: SearchFieldWidget(pushReplace: false),
          ),
          10.0.horizontalSpace,
          if (AppSharedPreference.isLogin)
            InkWell(
              onTap: () async {
                await Navigator.pushNamed(context, RouteName.notifications);
                if (context.mounted) {
                  context.read<NotificationCountCubit>().changeCount();
                }
              },
              child: Stack(
                children: [
                  Center(
                    child: ImageMultiType(
                      url: Assets.iconsBell,
                      height: 40.0.r,
                      color: Colors.black45,
                    ),
                  ),
                  BlocBuilder<NotificationCountCubit, NotificationCountInitial>(
                    builder: (context, state) {
                      return Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 21.0.r,
                          width: 21.0.r,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColorManager.mainColor, width: 3.0.r)),
                          child: Center(
                            child: DrawableText(
                              text: (state.result < 10) ? state.result.toString() : '9+',
                              color: AppColorManager.mainColor,
                              size: state.result < 10 ? 10.0.sp : 8.0.sp,
                              fontFamily: FontManager.cairoBold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({super.key, required this.pushReplace});

  final bool pushReplace;

  @override
  Widget build(BuildContext context) {
    final searchC = TextEditingController();
    return MyEditTextWidget(
      controller: searchC,
      icon: InkWell(
        onTap: () {
          var p0 = searchC.text;
          if (p0.isEmpty) return;
          if (pushReplace) {
            Navigator.pushReplacementNamed(context, RouteName.searchResult,
                arguments: p0);
          } else {
            Navigator.pushNamed(context, RouteName.searchResult, arguments: p0);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
          child: const ImageMultiType(url: Assets.iconsSearch),
        ),
      ),
      hint: 'ابحث عن ما تريد',
      textInputAction: TextInputAction.search,
      onFieldSubmitted: (p0) {
        if (p0.isEmpty) return;
        searchC.text = '';
        if (pushReplace) {
          Navigator.pushReplacementNamed(context, RouteName.searchResult, arguments: p0);
        } else {
          Navigator.pushNamed(context, RouteName.searchResult, arguments: p0);
        }
      },
    );
  }
}
