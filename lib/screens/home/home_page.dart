import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_delivery/screens/accounts/accounts_information.dart';
import 'package:food_delivery/screens/cart/cart_history.dart';
import 'package:food_delivery/screens/cart/cart_page.dart';
import 'package:food_delivery/screens/home/main_food_page.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: [
          PersistentBottomNavBarItem(
            icon: const Icon(CupertinoIcons.home),
            title: ("Home"),
            activeColorPrimary: AppColors.mainColor,
            inactiveColorPrimary: Colors.black45,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(CupertinoIcons.archivebox),
            activeColorPrimary: AppColors.mainColor,
            inactiveColorPrimary: Colors.black45,
            title: ("archive"),
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(CupertinoIcons.shopping_cart),
            activeColorPrimary: AppColors.mainColor,
            inactiveColorPrimary: Colors.black45,
            title: ("Cart"),
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(CupertinoIcons.person),
            activeColorPrimary: AppColors.mainColor,
            inactiveColorPrimary: Colors.black45,
            title: ("Person"),
          ),
        ],
        padding: const NavBarPadding.all(10),
        neumorphicProperties: const NeumorphicProperties(
          curveType: CurveType.concave,
          shape: BoxShape.rectangle,
          bevel: 15,
          borderRadius: 20,
        ),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.neumorphic, // Choose the nav bar style with this property.
      )
    );
  }

  List<Widget> _buildScreens() {
    return [
      const MainFoodPage(),
      Container(),
      const CartHistory(),
      const AccountInformation()
    ];
  }
}
