import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/screens/detail_page.dart';

Widget buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return ListTile(
    tileColor: Theme.of(context).listTileTheme.tileColor,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 8.0,
    ),
    leading: Hero(
      tag: restaurant.id,
      child: Image.network(
        restaurant.pictureId,
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
            Text(restaurant.city, style: const TextStyle(fontSize: 12)),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.star,
              size: 12,
            ),
            const SizedBox(width: 3),
            Text(
              restaurant.rating.toString(),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        )
      ],
    ),
    onTap: () {
      Navigator.pushNamed(context, RestaurantDetailPage.routeName,
          arguments: restaurant);
    },
  );
}
