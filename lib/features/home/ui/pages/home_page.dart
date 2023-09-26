import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';

import '../../../../core/widgets/bottom_nav_widget.dart';
import '../../../cart/bloc/add_to_cart_cubit/add_to_cart_cubit.dart';
import '../../../cart/ui/pages/cart_screen.dart';
import '../../../favorite/ui/pages/fav_screen.dart';
import '../../../settings/ui/pages/settings_screen.dart';
import '../widget/screens/home_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  var pageIndex = 0;

  @override
  Widget build(BuildContext context) {

    return BlocListener<AddToCartCubit, AddToCartInitial>(
      listenWhen: (p, c) => c.goToCart,
      listener: (context, state) {
        pageIndex = 1;
        setState(() => _pageController.jumpToPage(1));
      },
      child: WillPopScope(
        onWillPop: () async {
          if (pageIndex != 0) {
            pageIndex = 0;
            setState(() => _pageController.jumpToPage(0));
            return false;
          }
          return true;
        },
        child: Scaffold(
          appBar: const AppBarWidget(zeroHeight: true),
          bottomNavigationBar: NewNav(
            onChange: (index) {
              pageIndex = index;
              setState(() => _pageController.jumpToPage(index));
            },
            controller: _pageController,
          ),
          body: SizedBox.expand(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                HomeScreen(),
                CartScreen(),
                FavScreen(),
                SettingsScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
