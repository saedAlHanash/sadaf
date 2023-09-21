import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/features/home/ui/widget/screens/home_screen.dart';

import '../../../../core/widgets/images/image_multi_type.dart';
import '../../../../generated/assets.dart';
import '../../../cart/ui/pages/cart_screen.dart';
import '../../../favorite/ui/pages/fav_screen.dart';
import '../../../settings/ui/pages/settings_screen.dart';

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
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: ImageMultiType(url: Assets.iconsHome, color: Colors.white),
            backgroundColor: AppColorManager.mainColor),
        BottomNavigationBarItem(
            icon: ImageMultiType(url: Assets.iconsCart, color: Colors.white),
            backgroundColor: AppColorManager.mainColor),
        BottomNavigationBarItem(
            icon: ImageMultiType(url: Assets.iconsFav, color: Colors.white),
            backgroundColor: AppColorManager.mainColor),
        BottomNavigationBarItem(
            icon: ImageMultiType(url: Assets.iconsSetting, color: Colors.white),
            backgroundColor: AppColorManager.mainColor),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: (value) {},
      unselectedItemColor: Colors.red,
    );
  }
}
