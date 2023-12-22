import 'package:flutter/material.dart';
import 'package:restaurant_app/constants/references.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/ui/detail_page.dart';

Widget buildRestaurantItem(BuildContext context, RestaurantList restaurant) {
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
    onTap: () {
      Navigator.pushNamed(context, RestaurantDetailPage.routeName,
          arguments: restaurant.id);
    },
  );
}
