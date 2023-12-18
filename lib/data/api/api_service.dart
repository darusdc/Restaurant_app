import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/constants/references.dart';
import 'package:restaurant_app/data/models/restaurant.dart';

class ApiService {
  Future<RestaurantListResult> restaurantList() async {
    final response = await http.get(Uri.parse("$baseUrl/list"));
    if (response.statusCode == 200) {
      return RestaurantListResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants list');
    }
  }

  Future<DetailRestaurant> detailRestaurant(num id) async {
    final response = await http.get(Uri.parse("$baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }
}
