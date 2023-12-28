import 'package:flutter/material.dart';
import 'package:resto_mana/data/api/api_service.dart';
import 'package:resto_mana/data/models/restaurant.dart';

enum ResultState {
  loading,
  noData,
  hasData,
  error,
}

class RestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantsProvider({required this.apiService}) {
    fetchAllRestaurant();
  }

  late RestaurantListResult _restaurantList;
  ResultState _state = ResultState.loading;
  String _message = '';

  String get message => _message;

  RestaurantListResult get result => _restaurantList;

  ResultState get state => _state;

  Future<dynamic> fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantList();
      if (restaurant.count == 0) {
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

class DetailRestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;
  DetailRestaurantsProvider({required this.apiService, required this.id}) {
    fetchDetailRestaurant(id);
  }

  late DetailRestaurantResult _detailRestaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  DetailRestaurantResult get result => _detailRestaurant;

  ResultState get state => _state;

  Future<dynamic> fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.detailRestaurant(id);
      if (restaurant.restaurant.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurant = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

class ReviewProvider with ChangeNotifier {
  ApiService apiService;
  ReviewProvider({required this.apiService});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<dynamic> reviewProviderPost(
      String id, String reviewText, String name) async {
    try {
      _isLoading = true;
      notifyListeners();
      final reviews = await apiService.postReview(reviewText, name, id);
      if (reviews.name.isEmpty) {
        _isLoading = false;
        notifyListeners();
        return 'Empty Data';
      } else {
        _isLoading = false;
        notifyListeners();
        return reviews;
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return 'Error --> $e';
    }
  }
}

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;
  final String query;
  SearchProvider({required this.apiService, required this.query}) {
    fetchSearchResult(query);
  }

  List<RestaurantList> _searchResult = [];
  late ResultState _state;
  String _message = '';

  String get message => _message;

  List<RestaurantList> get result => _searchResult;

  ResultState get state => _state;

  Future<dynamic> fetchSearchResult(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final data = await apiService.searchRestaurants(query);
      if (data.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchResult = data.restaurants;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  void resetFilteredItems() {
    _searchResult = fetchSearchResult('') as List<RestaurantList>;
    notifyListeners();
  }
}
