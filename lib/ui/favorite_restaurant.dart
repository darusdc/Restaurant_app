import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';
import 'package:resto_mana/data/api/api_service.dart';
import 'package:resto_mana/data/realm/favorite_restaurant_realm.dart';
import 'package:resto_mana/provider/restaurants_provider.dart';
import 'package:resto_mana/utils/add_remove_restaurant.dart';
import 'package:resto_mana/widgets/build_item_restaurant.dart';
import 'package:resto_mana/widgets/platform_widget.dart';

final config = Configuration.local([FavoriteRestaurant.schema]);
final realm = Realm(config);

class FavoriteRestaurantPage extends StatefulWidget {
  const FavoriteRestaurantPage({super.key});
  static const routeName = "/favorite_restaurant";
  @override
  State<FavoriteRestaurantPage> createState() => _FavoriteRestaurantPageState();
}

class _FavoriteRestaurantPageState extends State<FavoriteRestaurantPage> {
  final favoriteRestaurants = realm.all<FavoriteRestaurant>();

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Restoran kesukaan')),
        body: ChangeNotifierProvider<RestaurantsProvider>(
          create: (context) => RestaurantsProvider(apiService: ApiService()),
          child: favoriteRestaurants.isEmpty
              ? Column(
                  children: [
                    Lottie.asset('assets/no_data.json'),
                    const Text(
                        "Kamu sepertinya belum menyukai satu restoranpun.")
                  ],
                )
              : Column(children: [_buildList()]),
        ));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar:
          const CupertinoNavigationBar(middle: Text('Restoran kesukaan')),
      child: ChangeNotifierProvider<RestaurantsProvider>(
        create: (context) => RestaurantsProvider(apiService: ApiService()),
        child: favoriteRestaurants.isEmpty
            ? Column(
                children: [
                  Lottie.asset('assets/no_data.json'),
                  const Text("Kamu sepertinya belum menyukai satu restoranpun.")
                ],
              )
            : Column(children: [_buildList()]),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantsProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          final restaurants = state.result.restaurants
              .where((element) => checkFavorite(element.id))
              .toList();
          return restaurants.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = restaurants[index];
                    return buildRestaurantItem(context, restaurant);
                  },
                )
              : Center(
                  child: Material(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 200,
                        ),
                        Lottie.asset('assets/no_data.json'),
                        const Text(
                            "Kamu sepertinya belum menyukai satu restoranpun"),
                      ],
                    ),
                  ),
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
}
