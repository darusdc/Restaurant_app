import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/provider/restaurants_provider.dart';
import 'package:restaurant_app/ui/restaurant_list.dart';
import 'package:restaurant_app/ui/settings_page.dart';
import 'package:restaurant_app/widgets/build_item_restaurant.dart';
import 'package:restaurant_app/ui/search_screen.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

// class HomePage extends StatelessWidget {
//   static const routeName = "/restaurant_list";
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     ScrollController sc = ScrollController();
//     List<RestaurantList> items = [];
//     return Scaffold(
//         appBar: AppBar(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: screenWidth > 300
//                 ? [
//                     Text(
//                       "Resto Mana?",
//                       style: Theme.of(context).textTheme.titleLarge,
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           Navigator.pushNamed(context, SearchScreen.routeName,
//                               arguments: items);
//                         },
//                         icon: const Icon(Icons.search))
//                   ]
//                 : [],
//           ),
//         ),
//         body: NestedScrollView(
//           controller: kIsWeb
//               ? null
//               : Platform.isAndroid || Platform.isIOS
//                   ? sc
//                   : null,
//           headerSliverBuilder: (context, innerBoxIsScrolled) {
//             return [
//               SliverAppBar(
//                 pinned: true,
//                 expandedHeight: 200,
//                 flexibleSpace: FlexibleSpaceBar(
//                   background: Image.asset(
//                     'assets/pexels-ella-olsson-1640777.jpg',
//                     fit: BoxFit.cover,
//                   ),
//                   title: Text(
//                     "Temukan Restoran Favoritmu:",
//                     textAlign: TextAlign.left,
//                     style: Theme.of(context).textTheme.titleSmall,
//                   ),
//                 ),
//               )
//             ];
//           },
//           body: SingleChildScrollView(
//             controller: kIsWeb
//                 ? null
//                 : Platform.isAndroid || Platform.isIOS
//                     ? sc
//                     : null,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: screenWidth > 300
//                   ? [
//                       FutureBuilder(
//                         future: DefaultAssetBundle.of(context)
//                             .loadString('assets/local_restaurant.json'),
//                         builder: (context, snapshot) {
//                           final List<Restaurant> restaurants =
//                               parseRestaurants(snapshot.data);
//                           items = restaurants;
//                           return ListView.builder(
//                             controller: kIsWeb
//                                 ? null
//                                 : Platform.isAndroid || Platform.isIOS
//                                     ? sc
//                                     : null,
//                             shrinkWrap: true,
//                             itemCount: restaurants.length,
//                             itemBuilder: (context, index) {
//                               return buildRestaurantItem(
//                                   context, restaurants[index]);
//                             },
//                           );
//                         },
//                       ),
//                     ]
//                   : [],
//             ),
//           ),
//         ));
//   }
// }

class HomePage extends StatefulWidget {
  static const routeName = "/homepage";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  static const String _restaurantText = "Restaurant List";
  final List<Widget> _listWidget = [
    ChangeNotifierProvider<RestaurantsProvider>(
      create: (context) => RestaurantsProvider(apiService: ApiService()),
      child: RestaurantListPage(),
    ),
    const SettingsPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.news : Icons.public),
      label: _restaurantText,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
      label: SettingsPage.settingsTitle,
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
