import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/util/shared_preferences.dart';

import '../../../../core/strings/app_color_manager.dart';
import 'package:image_multi_type/image_multi_type.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: SearchFieldWidget(pushReplace: false),
          ),
          10.0.horizontalSpace,
          Container(
            height: 45.0.h,
            width: 45.0.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black.withOpacity(.6),
              ),
            ),
            child: InkWell(
              onTap: () async {},
              child: ImageMultiType(
                url: Icons.filter_list_sharp,
                height: 30.0.r,
                color: Colors.grey,
              ),
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
    return Container(
      height: 45.0.h,
      padding: const EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withOpacity(.6),
        ),
      ),
      child: MyEditTextWidget(
        controller: searchC,
        backgroundColor: Colors.transparent,
        radios: 0.0,
        icon: InkWell(
          onTap: () {
            var p0 = searchC.text;
            if (p0.isEmpty) return;
            if (pushReplace) {
            } else {}
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
            child: const ImageMultiType(
              url: Assets.iconsSearch,
              color: AppColorManager.gray,
            ),
          ),
        ),
        hint: S.of(context).search_In_All,
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (p0) {
          if (p0.isEmpty) return;
          searchC.text = '';
          if (pushReplace) {
            // Navigator.pushReplacementNamed(context, RouteName.searchResult, arguments: p0);
          } else {
            // Navigator.pushNamed(context, RouteName.searchResult, arguments: p0);
          }
        },
      ),
    );
  }
}
