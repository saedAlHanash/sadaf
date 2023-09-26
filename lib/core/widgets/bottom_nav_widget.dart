import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/api_manager/api_service.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../generated/assets.dart';
import '../../features/cart/bloc/add_to_cart_cubit/add_to_cart_cubit.dart';
import '../../features/cart/bloc/update_cart_cubit/update_cart_cubit.dart';

// class BottomNavigator extends StatefulWidget {
//   const BottomNavigator({Key? key, required this.onChange}) : super(key: key);
//
//   final Function(int) onChange;
//
//   @override
//   State<BottomNavigator> createState() => BottomNavigatorState();
// }
//
// class BottomNavigatorState extends State<BottomNavigator> {
//   var selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60.0.h,
//       width: 1.0.sw,
//       clipBehavior: Clip.hardEdge,
//       decoration: BoxDecoration(
//         border: MyStyle.appBorderAll,
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(26.0.r),
//         ),
//       ),
//       child: BottomNavyBar(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         selectedIndex: selectedIndex,
//         ,
//         itemCornerRadius: 10.0.r,
//         onItemSelected: (value) {
//           setState(() => selectedIndex = value);
//           widget.onChange(value);
//         },
//         items: [
//           BottomNavyBarItem(
//             icon: const ImageMultiType(url: Assets.iconsHome, color: Colors.white),
//             title: DrawableText(
//               text: S.of(context).home,
//               color: Colors.white,
//               size: 14.0.spMin,
//             ),
//             activeColor: AppColorManager.whit,
//           ),
//           BottomNavyBarItem(
//             icon: const ImageMultiType(url: Assets.iconsCart, color: Colors.white),
//             title: DrawableText(
//               text: S.of(context).cart,
//               color: Colors.white,
//               size: 14.0.spMin,
//             ),
//             activeColor: AppColorManager.whit,
//           ),
//           BottomNavyBarItem(
//             icon: const ImageMultiType(url: Assets.iconsFav, color: Colors.white),
//             title: DrawableText(
//               text: S.of(context).fav,
//               color: Colors.white,
//               size: 14.0.spMin,
//             ),
//             activeColor: AppColorManager.whit,
//           ),
//           BottomNavyBarItem(
//             icon: const ImageMultiType(url: Assets.iconsSetting, color: Colors.white),
//             title: DrawableText(
//               text: S.of(context).settings,
//               color: Colors.white,
//               size: 14.0.spMin,
//             ),
//             activeColor: AppColorManager.whit,
//           ),
//         ],
//       ),
//     );
//   }
// }

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
      child: BottomNavigationBar(
        backgroundColor: AppColorManager.mainColor,
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
            icon: ImageMultiType(
              url: Assets.iconsSetting,
              color: Colors.white,
              height: 25.0.spMin,
            ),
            activeIcon: ImageMultiType(
              url: Assets.iconsSetting,
              color: Colors.white,
              height: 35.0.spMin,
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
    );
  }
}
