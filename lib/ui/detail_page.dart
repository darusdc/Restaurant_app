import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final DetailRestaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    List foods = restaurant.menus.foods;
    List drinks = restaurant.menus.drinks;
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
                      restaurant.pictureId,
                      fit: BoxFit.cover,
                    )),
                title: Text(restaurant.name,
                    style: Theme.of(context).textTheme.titleLarge),
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
                              Text(restaurant.city,
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
                            style: Theme.of(context).textTheme.headlineSmall,
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
                                          color: const Color.fromARGB(
                                                  255, 224, 196, 8)
                                              .withOpacity(0.8),
                                          height: 50,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
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
                                          color: const Color.fromARGB(
                                                  255, 224, 196, 8)
                                              .withOpacity(0.8),
                                          height: 50,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
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
        ),
      ),
    );
  }
}
