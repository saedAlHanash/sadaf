import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:sadaf/core/widgets/my_text_form_widget.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/verification_code_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/reset_password_cubit/reset_password_cubit.dart';
import '../../data/request/reset_password_request.dart';

class DonePage extends StatelessWidget {
  const DonePage({Key? key, required this.params}) : super(key: key);

  final DonePageParams params;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 70.0).r,
        child: MyButton(
          onTap: () {
            switch (params.type) {
              case DoneType.password:
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteName.login, (route) => false);
                break;
              case DoneType.signup:
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteName.home, (route) => false);
                break;
              case DoneType.order:
                break;
            }
          },
          text: S.of(context).done,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageMultiType(
              url: params.image,
              height: 90.0.r,
              width: 90.0.r,
            ),
            38.0.verticalSpace,
            DrawableText(
              text: params.header,
              size: 24.0.sp,
              fontFamily: FontManager.cairoBold,
              textAlign: TextAlign.center,
            ),
            17.0.verticalSpace,
            DrawableText(
              text: params.desc ?? '',
              size: 20.0.sp,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class DonePageParams {
  final DoneType type;
  final dynamic image;
  final String header;
  final String? desc;

  DonePageParams({
    required this.type,
    required this.header,
    this.image,
    this.desc,
  });
}
