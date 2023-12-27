import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:resto_mana/data/api/api_service.dart';
import 'package:resto_mana/data/models/restaurant.dart';
import 'package:resto_mana/provider/restaurants_provider.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  group('RestaurantsProvider', () {
    late RestaurantsProvider restaurantsProvider;
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
      restaurantsProvider = RestaurantsProvider(apiService: mockApiService);
    });

    test('Initial state is loading', () {
      expect(restaurantsProvider.state, ResultState.error);
    });

    test('Fetching restaurants updates state and result', () async {
      when(mockApiService.restaurantList()).thenAnswer(
        (_) async => RestaurantListResult(
            count: 1,
            error: false,
            message: 'success',
            restaurants: [
              RestaurantList(
                  id: 'ad',
                  name: 'name',
                  description: 'description',
                  pictureId: 'pictureId',
                  city: 'city',
                  rating: 4.2)
            ]),
      );

      await restaurantsProvider.fetchAllRestaurant();
      expect(restaurantsProvider.state, ResultState.hasData);
      expect(restaurantsProvider.result.restaurants.isNotEmpty, true);
    });

    test('Fetching restaurants with empty result updates state and message',
        () async {
      when(mockApiService.restaurantList()).thenAnswer((_) async =>
          RestaurantListResult(
              count: 0, error: false, message: 'Empty Data', restaurants: []));

      await restaurantsProvider.fetchAllRestaurant();

      expect(restaurantsProvider.state, ResultState.noData);
      expect(restaurantsProvider.message, 'Empty Data');
    });

    test('Fetching restaurants with error updates state and message', () async {
      when(mockApiService.restaurantList()).thenThrow(Exception('Some error'));

      await restaurantsProvider.fetchAllRestaurant();

      expect(restaurantsProvider.state, ResultState.error);
      expect(restaurantsProvider.message, 'Error --> Some error');
    });
  });
  group('DetailRestaurantsProvider', () {
    late DetailRestaurantsProvider detailRestaurantsProvider;
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
      detailRestaurantsProvider = DetailRestaurantsProvider(
          apiService: mockApiService, id: 'w9pga3s2tubkfw1e867');
    });

    test('Initial state is loading', () {
      expect(detailRestaurantsProvider.state, ResultState.loading);
    });

    test('Fetching detail restaurant updates state and result', () async {
      when(mockApiService.detailRestaurant('w9pga3s2tubkfw1e867')).thenAnswer(
          (_) async => DetailRestaurantResult(
              error: false,
              message: 'has data',
              restaurant: DetailRestaurant.fromJson(json.decode(
                  ' "id": "rqdv5juczeskfw1e867", "name": "Melting Pot", "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.", "pictureId": "https://restaurant-api.dicoding.dev/images/medium/14", "city": "Medan", "rating": 4.2,'))));

      await detailRestaurantsProvider
          .fetchDetailRestaurant('w9pga3s2tubkfw1e867');

      expect(detailRestaurantsProvider.state, ResultState.hasData);
      expect(detailRestaurantsProvider.result.restaurant.name.isNotEmpty, true);
    });

    test(
        'Fetching detail restaurant with empty result updates state and message',
        () async {
      when(mockApiService.detailRestaurant('w9pga3s2tubkfw1e867')).thenAnswer(
        (_) async => DetailRestaurantResult(
          error: true,
          message: 'no data',
          restaurant: DetailRestaurant.fromJson({}),
        ),
      );

      await detailRestaurantsProvider
          .fetchDetailRestaurant('w9pga3s2tubkfw1e867');

      expect(detailRestaurantsProvider.state, ResultState.noData);
      expect(detailRestaurantsProvider.message, 'Empty Data');
    });

    test('Fetching detail restaurant with error updates state and message',
        () async {
      when(mockApiService.detailRestaurant('w9pga3s2tubkfw1e867'))
          .thenThrow(Exception('Some error'));

      await detailRestaurantsProvider
          .fetchDetailRestaurant('w9pga3s2tubkfw1e867');

      expect(detailRestaurantsProvider.state, ResultState.error);
      expect(detailRestaurantsProvider.message, 'Error --> Some error');
    });
  });

  group('ReviewProvider', () {
    late ReviewProvider reviewProvider;
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
      reviewProvider = ReviewProvider();
    });

    test('Initial isLoading state is false', () {
      expect(reviewProvider.isLoading, false);
    });

    test('Posting review sets isLoading to true and then false', () async {
      when(mockApiService.postReview('Enak', "w9pga3s2tubkfw1e867", "Anonim"))
          .thenAnswer(
        (_) async => CustomerReview(
          name: 'Anonim',
          review: 'Enak',
          date: DateTime.now().toString(),
        ),
      );

      await reviewProvider.reviewProviderPost(mockApiService,
          'w9pga3s2tubkfw1e867', 'Great restaurant!', 'User123');

      expect(reviewProvider.isLoading, true);
      expect(reviewProvider.isLoading, false);
    });

    test(
        'Posting review with empty result sets isLoading to false and returns message',
        () async {
      when(mockApiService.postReview('Enak', "w9pga3s2tubkfw1e867", "Anonim"))
          .thenAnswer(
        (_) async => CustomerReview(
          name: 'Anonim',
          review: 'Enak',
          date: DateTime.now().toString(),
        ),
      );

      final result = await reviewProvider.reviewProviderPost(
          mockApiService, 'w9pga3s2tubkfw1e867', 'Great restaurant!', '');

      expect(result, 'Empty Data');
    });

    test(
        'Posting review with error sets isLoading to false and returns message',
        () async {
      when(mockApiService.postReview('Enak', "w9pga3s2tubkfw1e867", "Anonim"))
          .thenThrow(Exception('Some error'));

      final result = await reviewProvider.reviewProviderPost(
          mockApiService, 'some_id', 'Great restaurant!', 'User123');

      expect(result, 'Error --> Some error');
    });
  });
  group('SearchProvider', () {
    late SearchProvider searchProvider;
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
      searchProvider =
          SearchProvider(apiService: mockApiService, query: 'pizza');
    });

    test('Initial state is loading', () {
      expect(searchProvider.state, ResultState.loading);
    });

    test('Fetching search result updates state and result', () async {
      when(mockApiService.searchRestaurants('kafein')).thenAnswer(
        (_) async => SearchResult.fromJson(
          json.decode(
              '{"error": false, "founded": 1, "restaurants": [{"id": "uewq1zg2zlskfw1e867", "name": "Kafein","description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,", "pictureId": "15", "city": "Aceh", "rating": 4.6 }]}'),
        ),
      );

      await searchProvider.fetchSearchResult('pizza');

      expect(searchProvider.state, ResultState.hasData);
      expect(searchProvider.result.isNotEmpty, true);
    });

    test('Fetching search result with empty result updates state and message',
        () async {
      when(mockApiService.searchRestaurants('asqdqsd'))
          .thenAnswer((va) async => SearchResult.fromJson(
                json.decode(
                    '{"error": false, "founded": 0, "restaurants": [{}]}'),
              ));

      await searchProvider.fetchSearchResult('pizza');

      expect(searchProvider.state, ResultState.noData);
      expect(searchProvider.message, 'Empty Data');
    });

    test('Fetching search result with error updates state and message',
        () async {
      when(mockApiService.searchRestaurants('kafein'))
          .thenThrow(Exception('Some error'));

      await searchProvider.fetchSearchResult('pizza');

      expect(searchProvider.state, ResultState.error);
      expect(searchProvider.message, 'Error --> Some error');
    });

    test('Resetting filtered items should clear the result', () {
      searchProvider.resetFilteredItems();

      expect(searchProvider.result, isEmpty);
    });
  });
}
