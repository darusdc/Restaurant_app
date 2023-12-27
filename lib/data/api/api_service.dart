import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:resto_mana/constants/references.dart';
import 'package:resto_mana/data/models/restaurant.dart';

class ApiService {
  Future<RestaurantListResult> restaurantList() async {
    final response = await http.get(Uri.parse("$baseUrl/list"));
    if (response.statusCode == 200) {
      return RestaurantListResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants list');
    }
  }

  Future<DetailRestaurantResult> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<CustomerReview> postReview(
      String reviewText, String id, String name) async {
    const String apiUrl = '$baseUrl/review';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, String> reviewData = {
      'id': id,
      'name': name,
      'review': reviewText,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(reviewData),
      );

      if (response.statusCode == 201) {
        return CustomerReview.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to post Customer');
      }
    } catch (e) {
      throw Exception('There is error to sending data: $e');
    }
  }

  Future<SearchResult> searchRestaurants(String query) async {
    final String apiUrl = '$baseUrl/search?q=$query';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return SearchResult.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            'Error searching restaurants. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching restaurants: $e');
    }
  }
}
