import 'package:flutter/material.dart';
import 'package:resto_mana/constants/references.dart';
import 'package:resto_mana/data/models/restaurant.dart';
import 'package:resto_mana/ui/detail_page.dart';
import 'package:resto_mana/utils/add_remove_restaurant.dart';

Widget buildRestaurantItem(BuildContext context, RestaurantList restaurant) {
  bool isFavorite = checkFavorite(restaurant.id);
  return StatefulBuilder(
    builder: (context, setState) {
      return ListTile(
        tileColor: Theme.of(context).listTileTheme.tileColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        leading: Hero(
          tag: restaurant.id,
          child: Image.network(
            imageMediumUrl + restaurant.pictureId,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          restaurant.name,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 12,
                ),
                const SizedBox(width: 3),
                Text(restaurant.city,
                    style: const TextStyle(fontSize: 12),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  size: 12,
                ),
                const SizedBox(width: 3),
                Text(restaurant.rating.toString(),
                    style: const TextStyle(fontSize: 12),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis),
              ],
            )
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            isFavorite
                ? deleteFavoriteRestaurant(restaurant.id, context)
                : addFavoriteRestaurant(restaurant.id, context);
            setState(
              () {
                isFavorite = checkFavorite(restaurant.id);
              },
            );
          },
          icon: isFavorite
              ? const Icon(Icons.favorite, color: Colors.red)
              : const Icon(Icons.favorite_border),
        ),
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                  arguments: restaurant.id)
              .then((value) {
            setState(
              () {
                isFavorite = checkFavorite(restaurant.id);
              },
            );
          });
        },
      );
    },
  );
}
