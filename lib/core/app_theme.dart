import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';

const primaryColor = AppColorManager.mainColor;
const secondaryColor = AppColorManager.mainColorDark;

final appTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      centerTitle: true,
    ),
    switchTheme: const SwitchThemeData(
        thumbColor: MaterialStatePropertyAll(primaryColor),
        overlayColor: MaterialStatePropertyAll(secondaryColor)),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
        primary: primaryColor, secondary: secondaryColor, background: Colors.white),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: primaryColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      iconSize: 30.0.r,
      smallSizeConstraints: BoxConstraints(
        maxWidth: 30.0.r,
        maxHeight: 30.0.r,
      ),
      foregroundColor: secondaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: const TextStyle(color: primaryColor),
        iconColor: secondaryColor,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: secondaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(8),
        )),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          alignment: Alignment.center,
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColorManager.mainColor.withOpacity(0.8);
              }
              return AppColorManager.mainColor; // Use the component's default.
            },
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) => secondaryColor,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              15.0.r,
            ),
          ))),
    ),
    dividerTheme: DividerThemeData(
      color: AppColorManager.dividerColor,
      endIndent: 36.0.w,
      indent: 36.0.w,
      space: 40.0.h,
      thickness: 1.0.h,
    ),
    iconButtonTheme: IconButtonThemeData(
        style:
            ButtonStyle(padding: MaterialStatePropertyAll(const EdgeInsets.all(2.0).r))),
    checkboxTheme: const CheckboxThemeData(
      fillColor: MaterialStatePropertyAll(AppColorManager.mainColor),
    ),
    scaffoldBackgroundColor: AppColorManager.whit);
