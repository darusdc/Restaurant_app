import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:resto_mana/data/api/api_service.dart';
import 'package:resto_mana/data/models/restaurant.dart';
import 'package:resto_mana/provider/restaurants_provider.dart';
import 'package:resto_mana/widgets/build_item_restaurant.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/search";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String query = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Resto Favoritmu!'),
      ),
      body: ChangeNotifierProvider<SearchProvider>(
        create: (context) =>
            SearchProvider(apiService: ApiService(), query: query),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<SearchProvider>(
                builder: (context, value, child) {
                  return TextField(
                    controller: _searchController,
                    onSubmitted: (query) {
                      value.fetchSearchResult(query);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Cari',
                      hintText: 'Masukkan kata kuncinya di sini',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: _buildList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<SearchProvider>(
      builder: (context, searchProvider, _) {
        final List<RestaurantList> filteredItems = searchProvider.result;

        if (searchProvider.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (searchProvider.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              var restaurant = filteredItems[index];
              return buildRestaurantItem(context, restaurant);
            },
          );
        } else if (searchProvider.state == ResultState.noData) {
          return SingleChildScrollView(
            child: Center(
              child: Material(
                child: Column(
                  children: [
                    Lottie.asset('assets/data-not-found.json'),
                    const Text("Tidak ditemukan, coba kata kunci lain"),
                  ],
                ),
              ),
            ),
          );
        } else {
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
        }
      },
    );
  }
}
