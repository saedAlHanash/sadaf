
import 'package:carousel_slider/carousel_slider.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../generated/assets.dart';
import '../strings/app_color_manager.dart';
import '../strings/app_string_manager.dart';
import '../widgets/images/image_multi_type.dart';
import '../widgets/my_button.dart';
import '../widgets/snake_bar_widget.dart';

class NoteMessage {
  static void showSuccessSnackBar(
      {required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  static void showErrorSnackBar(
      {required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  static void showSnakeBar({
    required String? message,
    required BuildContext context,
  }) {
    final snack = SnackBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      content: SnakeBarWidget(text: message ?? ''),
    );

    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  static showBottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (builder) => child,
    );
  }

  static Future<bool> showBottomSheet1(
      BuildContext context, Widget child) async {
    final result = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(20.0.r),
          topStart: Radius.circular(20.0.r),
        ),
      ),
      builder: (context) => child,
    );

    return result ?? false;
  }



  static showDoneDialog(BuildContext context,
      {required String text, Function()? onCancel}) async {
    // show the dialog
    await showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0.r),
            ),
          ),
          elevation: 10.0,
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 150.0.h,
                // child: LottieBuilder.asset(Assets.lottiesMochup03Done),
              ),
              10.0.verticalSpace,
              DrawableText(
                text: text,
                size: 16.0.spMin,
                color: Colors.black,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15)
                        .r,
                child: MyButton(
                  text: AppStringManager.done,
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (onCancel != null) {
      onCancel();
    }
  }

  static Future<bool> showConfirm(BuildContext context,
      {required String text}) async {
    // show the dialog
    final result = await showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0.r),
            ),
          ),
          elevation: 10.0,
          clipBehavior: Clip.hardEdge,
          child: Padding(
            padding: const EdgeInsets.all(15.0).r,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DrawableText(
                  text: text,
                  size: 22.0.spMin,
                  fontFamily: FontManager.cairoBold,
                  color: AppColorManager.mainColorDark,
                ),
                40.0.verticalSpace,
                MyButton(
                  text: AppStringManager.confirm,
                  onTap: () => Navigator.pop(context, true),
                ),
                10.0.verticalSpace,
                MyButton(
                  text: AppStringManager.cancel,
                  onTap: () => Navigator.pop(context, false),
                  color: AppColorManager.black,
                ),
                20.0.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
    return (result ?? false);
  }

  static Future<bool> showErrorDialog(BuildContext context,
      {required String text, bool tryAgne = true}) async {
    // show the dialog
    final result = await showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0.r)),
          ),
          elevation: 10.0,
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DrawableText(
                text: 'Oops!',
                size: 20.0.spMin,
                padding: const EdgeInsets.symmetric(vertical: 15.0).h,
                fontFamily: FontManager.cairoBold,
                color: AppColorManager.textColor,
              ),
              const Divider(color: Colors.black),
              DrawableText(
                text: text,
                textAlign: TextAlign.center,
                size: 16.0.spMin,
                padding: const EdgeInsets.symmetric(vertical: 20.0).h,
                fontFamily: FontManager.cairoBold,
                color: AppColorManager.textColor,
              ),
              const Divider(color: Colors.black),
              TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: DrawableText(text: tryAgne ? 'Try Again' : 'OK'))
            ],
          ),
        );
      },
    );

    return (result ?? false);
  }

  static void showDialogError(
    BuildContext context, {
    required String text,
  }) {
    // show the dialog
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0.r)),
          ),
          elevation: 10.0,
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DrawableText(
                text: 'Oops!',
                size: 20.0.spMin,
                padding: const EdgeInsets.symmetric(vertical: 15.0).h,
                fontFamily: FontManager.cairoBold,
                color: AppColorManager.textColor,
              ),
              const Divider(color: Colors.black),
              DrawableText(
                text: text,
                textAlign: TextAlign.center,
                size: 16.0.spMin,
                padding: const EdgeInsets.symmetric(vertical: 20.0).h,
                fontFamily: FontManager.cairoBold,
                color: AppColorManager.textColor,
              ),
              const Divider(color: Colors.black),
              TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const DrawableText(text: 'OK'))
            ],
          ),
        );
      },
    );
  }

  static Future<bool> showMyDialog(BuildContext context,
      {required Widget child}) async {
    // show the dialog
    final result = await showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0.r),
            ),
          ),
          insetPadding: const EdgeInsets.all(20.0).r,
          elevation: 10.0,
          clipBehavior: Clip.hardEdge,
          child: SingleChildScrollView(
            child: child,
          ),
        );
      },
    );
    return (result ?? false);
  }
}
