import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:resto_mana/constants/references.dart';
import 'package:resto_mana/provider/restaurants_provider.dart';
import 'package:resto_mana/ui/favorite_restaurant.dart';
import 'package:resto_mana/ui/search_screen.dart';
import 'package:resto_mana/widgets/build_item_restaurant.dart';
import 'package:resto_mana/widgets/platform_widget.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  Widget _buildList() {
    return Consumer<RestaurantsProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return buildRestaurantItem(context, restaurant);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Lottie.asset('assets/no_data.json'),
                  const Text("There is no data from server!"),
                ],
              ),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Lottie.asset('assets/network_error.json'),
                  const Text("Check your connection or server status!"),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    ScrollController sc = ScrollController();
    ThemeData themes = Theme.of(context);
    return StatefulBuilder(
      builder: (context, setState) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: themes.primaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: screenWidth > limitWidth
                  ? [
                      Text(
                        "Resto Mana?",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                        context, SearchScreen.routeName)
                                    .then(
                                  (value) {
                                    setState(
                                      () {},
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.search)),
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context,
                                        FavoriteRestaurantPage.routeName)
                                    .then(
                                  (value) {
                                    setState(
                                      () {},
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.favorite))
                        ],
                      ),
                    ]
                  : [],
            ),
          ),
          body: NestedScrollView(
            controller: kIsWeb
                ? null
                : Platform.isAndroid || Platform.isIOS
                    ? sc
                    : null,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: themes.primaryColor,
                  pinned: true,
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      'assets/pexels-ella-olsson-1640777.jpg',
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      "Temukan Restoran Favoritmu:",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                )
              ];
            },
            body: SingleChildScrollView(
              controller: kIsWeb
                  ? null
                  : Platform.isAndroid || Platform.isIOS
                      ? sc
                      : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: screenWidth > limitWidth ? [_buildList()] : [],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIos(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return StatefulBuilder(
      builder: (context, setState) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: screenWidth > limitWidth
                  ? [
                      Text(
                        "Resto Mana?",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                        context, SearchScreen.routeName)
                                    .then(
                                  (value) {
                                    setState(
                                      () {},
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.search)),
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context,
                                        FavoriteRestaurantPage.routeName)
                                    .then(
                                  (value) {
                                    setState(
                                      () {},
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.favorite))
                        ],
                      ),
                    ]
                  : [],
            ),
            transitionBetweenRoutes: false,
          ),
          child: _buildList(),
        );
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
