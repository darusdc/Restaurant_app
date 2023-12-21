import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurants_provider.dart';
import 'package:restaurant_app/ui/detail_restaurant_page.dart';
import 'package:restaurant_app/ui/review_page.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final String restaurantId;

  const RestaurantDetailPage({Key? key, required this.restaurantId})
      : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  int _bottomNavIndex = 0;
  static const String _restaurantText = "Detail Restaurant";
  static String restaurantId = '';
  @override
  void initState() {
    super.initState();
    restaurantId = widget.restaurantId;
  }

  final List<Widget> _listWidget = [
    ChangeNotifierProvider<DetailRestaurantsProvider>(
      create: (context) =>
          DetailRestaurantsProvider(apiService: ApiService(), id: restaurantId),
      child: const DetailRestaurantPage(),
    ),
    ChangeNotifierProvider<DetailRestaurantsProvider>(
      create: (context) =>
          DetailRestaurantsProvider(apiService: ApiService(), id: restaurantId),
      child: ReviewsPage(
        id: restaurantId,
      ),
    ),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.news : Icons.public),
      label: _restaurantText,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
      label: ReviewsPage.reviewsTitle,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _bottomNavBarItems,
        activeColor: secondaryColor,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
