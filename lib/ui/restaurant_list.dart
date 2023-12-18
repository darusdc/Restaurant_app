import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/provider/restaurants_provider.dart';
import 'package:restaurant_app/ui/search_screen.dart';
import 'package:restaurant_app/widgets/build_item_restaurant.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

// ignore: must_be_immutable
class RestaurantListPage extends StatelessWidget {
  RestaurantListPage({super.key});

  List<RestaurantList> items = [];
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
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
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
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: screenWidth > 300
                ? [
                    Text(
                      "Resto Mana?",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SearchScreen.routeName,
                              arguments: items);
                        },
                        icon: const Icon(Icons.search))
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
                    style: Theme.of(context).textTheme.titleSmall,
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
              children: screenWidth > 300 ? [_buildList()] : [],
            ),
          ),
        ));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Resto Mana?'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
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
