import 'package:flutter/material.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';

import 'package:image_multi_type/image_multi_type.dart';
import '../../../../generated/assets.dart';

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
