import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/constants/references.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/provider/restaurants_provider.dart';

class DetailRestaurantPage extends StatelessWidget {
  const DetailRestaurantPage({super.key});

  Widget _buildDetail() {
    return Consumer<DetailRestaurantsProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          var restaurant = state.result.restaurant;
          return Platform.isAndroid
              ? _buildRestaurantAndroid(context, restaurant: restaurant)
              : Platform.isIOS
                  ? _buildIos(context, restaurant: restaurant)
                  : _buildRestaurantAndroid(context, restaurant: restaurant);
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

  Widget _buildIos(BuildContext context,
      {required DetailRestaurant restaurant}) {
    ScrollController sc = ScrollController();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Detil Resto ${restaurant.name}'),
        transitionBetweenRoutes: false,
      ),
      child: _generateDetail(context, restaurant: restaurant, sc: sc),
    );
  }

  Widget _buildRestaurantAndroid(BuildContext context,
      {required DetailRestaurant restaurant}) {
    ScrollController sc = ScrollController();
    return Scaffold(
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
                background: Hero(
                    tag: restaurant.id,
                    child: Image.network(
                      imageMediumUrl + restaurant.pictureId,
                      fit: BoxFit.cover,
                    )),
                title: Text(restaurant.name,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
            )
          ];
        },
        body: _generateDetail(context, restaurant: restaurant, sc: sc),
      ),
    );
  }

  Widget _generateDetail(BuildContext context,
      {required DetailRestaurant restaurant, required ScrollController sc}) {
    double screenWidth = MediaQuery.of(context).size.width;
    List foods = restaurant.menus.foods;
    List drinks = restaurant.menus.drinks;
    String restoCategory =
        restaurant.categories.map((e) => '${e.name}, ').join();
    return SingleChildScrollView(
      controller: kIsWeb
          ? null
          : Platform.isAndroid || Platform.isIOS
              ? sc
              : null,
      child: Column(
        children: screenWidth > 300
            ? [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(restaurant.name,
                          style: Theme.of(context).textTheme.titleLarge),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Text('${restaurant.address}, ${restaurant.city}',
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.category,
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Text(
                              restoCategory.replaceRange(
                                  restoCategory.length - 2,
                                  restoCategory.length,
                                  ""),
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        restaurant.description,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Menu:",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Makanan:",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: (screenWidth / 150).round(),
                          children: foods.map(
                            (food) {
                              return Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/pexels-ella-olsson-1640777.jpg'),
                                          fit: BoxFit.cover)),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      color:
                                          const Color.fromARGB(255, 224, 196, 8)
                                              .withOpacity(0.8),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          food.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList()),
                      const SizedBox(height: 10),
                      Text(
                        "Minuman:",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: (screenWidth / 150).round(),
                          children: drinks.map(
                            (drink) {
                              return Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/pexels-muhammad-fawdy-13573779.jpg'),
                                          fit: BoxFit.cover)),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      color:
                                          const Color.fromARGB(255, 224, 196, 8)
                                              .withOpacity(0.8),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          drink.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList()),
                    ],
                  ),
                ),
              ]
            : [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDetail();
  }
}
