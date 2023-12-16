import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/components/build_item_restaurant.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/screens/search_screen.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/restaurant_list";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    ScrollController sc = ScrollController();
    List<Restaurant> items = [];
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
              children: screenWidth > 300
                  ? [
                      FutureBuilder(
                        future: DefaultAssetBundle.of(context)
                            .loadString('assets/local_restaurant.json'),
                        builder: (context, snapshot) {
                          final List<Restaurant> restaurants =
                              parseRestaurants(snapshot.data);
                          items = restaurants;
                          return ListView.builder(
                            controller: kIsWeb
                                ? null
                                : Platform.isAndroid || Platform.isIOS
                                    ? sc
                                    : null,
                            shrinkWrap: true,
                            itemCount: restaurants.length,
                            itemBuilder: (context, index) {
                              return buildRestaurantItem(
                                  context, restaurants[index]);
                            },
                          );
                        },
                      ),
                    ]
                  : [],
            ),
          ),
        ));
  }
}
