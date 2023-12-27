import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:resto_mana/data/api/api_service.dart';
import 'package:resto_mana/data/models/restaurant.dart';
import 'package:resto_mana/provider/restaurants_provider.dart';

import 'provider_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
void main() {
  group('RestaurantsProvider', () {
    late RestaurantsProvider restaurantsProvider;
    late ApiService apiService;

    setUp(() {
      apiService = ApiService();
      restaurantsProvider = RestaurantsProvider(apiService: apiService);
    });

    test('Initial state is loading', () {
      expect(restaurantsProvider.state, ResultState.loading);
    });

    test('Fetching restaurants updates state and result', () async {
      await restaurantsProvider.fetchAllRestaurant().whenComplete(() {
        expect(restaurantsProvider.state, ResultState.hasData);
        expect(restaurantsProvider.result.restaurants.isNotEmpty, true);
      });
    });
  });
}
