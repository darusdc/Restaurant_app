import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/restaurant.dart';

enum ResultState {
  loading,
  noData,
  hasData,
  error,
}

class RestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantsProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantListResult _restaurantList;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantListResult get result => _restaurantList;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantList();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantList = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
