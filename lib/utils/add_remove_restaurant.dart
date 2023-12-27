import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:resto_mana/data/realm/favorite_restaurant_realm.dart';

final config = Configuration.local([FavoriteRestaurant.schema]);
final realm = Realm(config);

const userId = "User1";

void addFavoriteRestaurant(String id, BuildContext context) {
  final currentData = realm.all<FavoriteRestaurant>();
  if (currentData.isEmpty) {
    realm.write(() {
      realm.add(FavoriteRestaurant(ObjectId(), userId, idProducts: [id]));
    });
  } else {
    realm.write(() {
      currentData[0].idProducts.add(id);
    });
  }
  ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text('Berhasil ditambahkan')));
}

void deleteFavoriteRestaurant(String id, BuildContext context) {
  final currentData = realm.all<FavoriteRestaurant>();
  if (currentData.isNotEmpty) {
    realm.write(() {
      currentData[0].idProducts.remove(id);
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Berhasil dihapus')));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anda belum memiliki Restoran favorit')));
  }
}

bool checkFavorite(String id) {
  final currentData = realm.all<FavoriteRestaurant>();
  if (currentData.isEmpty) {
    return false;
  } else {
    return currentData[0].idProducts.contains(id);
  }
}
