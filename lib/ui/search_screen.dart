import 'package:flutter/material.dart';
import 'package:restaurant_app/widgets/build_item_restaurant.dart';
import 'package:restaurant_app/data/models/restaurant.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/search";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<RestaurantList> restaurants = [];
  List<RestaurantList> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = restaurants;
  }

  void filterSearchResults(String query) {
    List<RestaurantList> searchResults = [];
    if (query.isNotEmpty) {
      for (RestaurantList item in restaurants) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(item);
        }
      }
    } else {
      searchResults = restaurants;
    }

    setState(() {
      filteredItems = searchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Resto Favoritmu!'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              decoration: const InputDecoration(
                labelText: 'Cari',
                hintText: 'Masukkan kata kuncinya di sini',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return buildRestaurantItem(context, filteredItems[index]);
                }),
          ),
        ],
      ),
    );
  }
}
