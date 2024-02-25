import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/widgets/my_button.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';

class DoneCreateOrderPage extends StatelessWidget {
  const DoneCreateOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          0.0.verticalSpace,
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0).r,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageMultiType(
                    url: Assets.iconsDoneIcon,
                    height: 150.0.spMin,
                    width: 150.0.spMin,
                  ),
                  15.0.verticalSpace,
                  DrawableText(
                    text: S.of(context).confirmPayment,
                    fontFamily: FontManager.cairoBold.name,
                    color: Colors.black,
                    size: 28.0.spMin,
                  ),
                ],
              ),
            ),
          ),
          MyButton(
            text: 'تم',
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
