import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:sadaf/core/api_manager/api_service.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../generated/assets.dart';
import '../../features/cart/bloc/add_to_cart_cubit/add_to_cart_cubit.dart';
import '../../features/cart/bloc/update_cart_cubit/update_cart_cubit.dart';
import '../util/shared_preferences.dart';

class NewNav extends StatefulWidget {
  const NewNav({
    Key? key,
    required this.controller,
    required this.onChange,
  }) : super(key: key);

  final PageController controller;
  final Function(int) onChange;

  @override
  State<NewNav> createState() => _NewNavState();
}

class _NewNavState extends State<NewNav> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddToCartCubit, AddToCartInitial>(
      listenWhen: (p, c) => c.goToCart,
      listener: (context, state) => setState(() => selectedIndex = 1),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColorManager.mainColorLight,
              AppColorManager.mainColor,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageMultiType(
                url: Assets.iconsHome,
                color: Colors.white,
                height: 25.0.spMin,
              ),
              activeIcon: ImageMultiType(
                url: Assets.iconsHome,
                color: Colors.white,
                height: 35.0.spMin,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Center(
                    child: ImageMultiType(
                      url: Assets.iconsCart,
                      color: Colors.white,
                      height: 25.0.spMin,
                    ),
                  ),
                  BlocBuilder<UpdateCartCubit, UpdateCartInitial>(
                    builder: (context, state) {
                      return Positioned(
                        top: 0.0,
                        right: 25.0.r,
                        child: Container(
                          height: 21.0.r,
                          width: 21.0.r,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColorManager.mainColor, width: 3.0.r),
                          ),
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
              activeIcon: ImageMultiType(
                url: Assets.iconsCart,
                color: Colors.white,
                height: 35.0.spMin,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageMultiType(
                url: Assets.iconsFav,
                color: Colors.white,
                height: 25.0.spMin,
              ),
              activeIcon: ImageMultiType(
                url: Assets.iconsFav,
                color: Colors.white,
                height: 35.0.spMin,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                height: 30.0.r,
                width: 30.0.r,
                decoration:
                    const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: CircleImageWidget(
                  url: AppSharedPreference.getUserModel.avatar,
                  color: Colors.white,
                  size: 25.0.spMin,
                ),
              ),
              activeIcon:  Container(
                height: 35.0.r,
                width: 35.0.r,
                decoration:
                const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: CircleImageWidget(
                  url: AppSharedPreference.getUserModel.avatar,
                  color: Colors.white,
                  size: 30.0.spMin,
                ),
              ),
              label: '',
            ),
          ],
          currentIndex: selectedIndex,
          onTap: (value) {
            widget.onChange.call(value);
            setState(() => selectedIndex = value);
          },
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
