import 'dart:io';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/util/my_style.dart';

import '../../app/bloc/loading_cubit.dart';
import '../../strings/app_color_manager.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    Key? key,
    this.titleText,
    this.elevation,
    this.action,
    this.zeroHeight, this.actions,
  }) : super(key: key);

  final String? titleText;
  final List<Widget>? action;
  final bool? zeroHeight;
  final double? elevation;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => context.read<LoadingCubit>().isLoadingForPop(),
      child: AppBar(
        backgroundColor: AppColorManager.whit,
        toolbarHeight: (zeroHeight ?? false) ? 0 : 80.0.h,
        title: DrawableText(
          text: titleText ?? '',
          size: 28.0.spMin,
          fontFamily: FontManager.cairoBold,
        ),
        leading: Navigator.canPop(context) ? const BackBtnWidget() : null,
        actions: actions,
        elevation: elevation ?? 0.0,
        shadowColor: AppColorManager.black.withOpacity(0.28),
        iconTheme: const IconThemeData(color: AppColorManager.mainColor),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(1.0.sw,(zeroHeight ?? false) ? 0 : 80.0.h);
}
