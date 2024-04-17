import 'package:elwekala_ecommerce_app/model/onboarding-model.dart';
import 'package:elwekala_ecommerce_app/services/cache-helper.dart';
import 'package:elwekala_ecommerce_app/view/screens/cart-screen.dart';
import 'package:elwekala_ecommerce_app/view/screens/favorite-screen.dart';
import 'package:elwekala_ecommerce_app/view/screens/home-screen.dart';
import 'package:elwekala_ecommerce_app/view/screens/profile-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
      image: 'assets/images/onboarding-3.jpg',
      title: 'Choose Your Product',
      subtitle: ' welcome to wekala store for technical products'),
  OnBoardingModel(
      image: 'assets/images/onboarding-1.jpg',
      title: 'Add To Cart',
      subtitle: ' with one click choose your products '),
  OnBoardingModel(
      image: 'assets/images/onboarding-2.jpg',
      title: 'easy shopping ',
      subtitle: ' it is your community for shopping '),
];

String image = 'assets/images/cart.jpg';
Widget? screen;
String homeTitle = "Elwekala";
String productTitle = "Product Details";
String cartTitle = "My Cart ";
String favoriteTite = "My Favorites";
String profileTitle = "My Profile";

String nationalId = CacheHelper.getData(key: "nationalId");
String token = CacheHelper.getData(key: "token");


List<Widget> buildScreens() {
  return [
    const HomeScreen(),
    const CartScreen(),
    const FavoriteScreen(),
    const ProfileScreen()
  ];
}

List<PersistentBottomNavBarItem> navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.home),
      title: "Home",
      activeColorPrimary: CupertinoColors.systemPurple,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.shopping_cart),
      title: "Cart",
      activeColorPrimary: CupertinoColors.systemPurple,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.favorite),
      title: "Favourite",
      activeColorPrimary: CupertinoColors.systemPurple,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.profile_circled),
      title: "Profile",
      activeColorPrimary: CupertinoColors.systemPurple,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}
