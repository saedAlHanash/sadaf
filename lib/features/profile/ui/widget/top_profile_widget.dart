import 'dart:typed_data';
import 'dart:ui';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/api_manager/api_service.dart';
import 'package:sadaf/core/util/shared_preferences.dart';

import '../../../../core/widgets/item_image_create.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/profile_cubit/profile_cubit.dart';

class TopProfileWidget extends StatefulWidget {
  const TopProfileWidget(
      {super.key,
      required this.children,
      this.title,
      this.file,
      this.onLoad,
      this.updateImage});

  final List<Widget> children;
  final String? title;
  final UploadFile? file;
  final bool? updateImage;
  final Function(Uint8List bytes)? onLoad;

  @override
  State<TopProfileWidget> createState() => _TopProfileWidgetState();
}

class _TopProfileWidgetState extends State<TopProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileInitial>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 273.0.h,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: ImageMultiType(
                      url: widget.file?.fileBytes ?? state.result.avatar,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        color: Colors.grey.withOpacity(0.1),
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  Positioned(
                    width: 1.0.sw,
                    bottom: 0.0,
                    child: Transform.flip(
                      flipX: true,
                      child: const ImageMultiType(
                        url: Assets.iconsProfileTrangle,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: DrawableText(
                        matchParent: true,
                        textAlign: TextAlign.center,
                        color: Colors.white,
                        fontFamily: FontManager.cairoBold.name,
                        size: 24.0.sp,
                        drawableAlin: DrawableAlin.between,
                        text: S.of(context).profile,
                        drawableStart: InkWell(
                          onTap: () => widget.title == null
                              ? Scaffold.of(context).openDrawer()
                              : Navigator.pop(context),
                          child: ImageMultiType(
                            url: widget.title == null
                                ? Assets.iconsMenue
                                : Icons.arrow_back_ios,
                            color: Colors.white,
                            height: widget.title == null ? 12.0.r : 30.0.r,
                            width: widget.title == null ? 33.0.r : 30.0.r,
                          ),
                        ),
                        drawableEnd: 33.0.horizontalSpace,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 60.w,
                    child: (widget.updateImage ?? true)
                        ? ItemImageCreate(
                            onLoad: (bytes) {
                              return widget.onLoad?.call(bytes);
                            },
                            image: widget.file?.fileBytes ??
                                widget.file?.initialImage ??
                                state.result.avatar,
                          )
                        : Container(
                            height: 100.0.r,
                            width: 100.0.r,
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: ImageMultiType(
                              url: state.result.avatar,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0).r,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        DrawableText(
                          text: widget.title ?? '',
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 150.0.w,
                          child: Column(
                            children: [
                              DrawableText(
                                text: state.result.name,
                                textAlign: TextAlign.right,
                                fontFamily: FontManager.cairoBold.name,
                                size: 24.0.sp,
                              ),
                              DrawableText(
                                text: state.result.emailOrPhone,
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.0.verticalSpace,
                  ...widget.children
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
