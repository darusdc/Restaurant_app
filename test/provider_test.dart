import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:resto_mana/data/api/api_service.dart';
import 'package:resto_mana/data/models/restaurant.dart';
import 'package:resto_mana/provider/restaurants_provider.dart';

import 'provider_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateNiceMocks([MockSpec<ApiService>()])
void main() {
  group('RestaurantsProvider', () {
    late RestaurantsProvider restaurantsProvider;
    late MockApiService apiService;

    setUp(() {
      apiService = MockApiService();
      restaurantsProvider = RestaurantsProvider(apiService: apiService);
    });

    test('Initial state is loading', () {
      // Set state to error when using Mock, if use the real API use loading was passed
      expect(restaurantsProvider.state, ResultState.error);
    });

    test('Fetching restaurants updates state and result', () async {
      when(apiService.restaurantList()).thenAnswer(
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
      await restaurantsProvider.fetchAllRestaurant().whenComplete(() {
        expect(restaurantsProvider.state, ResultState.hasData);
        expect(restaurantsProvider.result.restaurants.isNotEmpty, true);
      });
    });

    test('Fetching restaurants with empty result updates state and message',
        () async {
      when(apiService.restaurantList()).thenAnswer((_) async =>
          RestaurantListResult(
              count: 0, error: false, message: 'Empty Data', restaurants: []));

      await restaurantsProvider.fetchAllRestaurant();

      expect(restaurantsProvider.state, ResultState.noData);
      expect(restaurantsProvider.message, 'Empty Data');
    });

    test('Fetching restaurants with error updates state and message', () async {
      when(apiService.restaurantList()).thenThrow(Exception('Some error'));

      await restaurantsProvider.fetchAllRestaurant();

      expect(restaurantsProvider.state, ResultState.error);
      expect(restaurantsProvider.message, 'Error --> Exception: Some error');
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
      // Set state to error when using Mock, if use the real API use loading was passed
      expect(detailRestaurantsProvider.state, ResultState.error);
    });

    test('Fetching detail restaurant updates state and result', () async {
      when(mockApiService.detailRestaurant('w9pga3s2tubkfw1e867')).thenAnswer(
          (_) async => DetailRestaurantResult(
              error: false,
              message: 'success',
              restaurant: DetailRestaurant(
                  id: "w9pga3s2tubkfw1e867",
                  name: "Melting Pot",
                  description:
                      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
                  pictureId:
                      "https://restaurant-api.dicoding.dev/images/medium/14",
                  city: "Medan",
                  rating: 4.2,
                  address: "asd",
                  categories: [Category(name: 'name')],
                  customerReviews: [
                    CustomerReview(name: 'name', review: 'review', date: 'date')
                  ],
                  menus: Menus(
                      foods: [Category(name: 'name')],
                      drinks: [Category(name: 'name')]))));

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
              error: false,
              message: 'success',
              restaurant: DetailRestaurant(
                  id: "",
                  name: "",
                  description: "",
                  pictureId: "",
                  city: "",
                  rating: 0,
                  address: "",
                  categories: [],
                  customerReviews: [],
                  menus: Menus(foods: [], drinks: []))));

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
      expect(searchProvider.state, ResultState.error);
    });

    test('Fetching search result updates state and result', () async {
      when(mockApiService.searchRestaurants('pizza')).thenAnswer(
          (realInvocation) async =>
              SearchResult(error: false, founded: 1, restaurants: [
                RestaurantList(
                    id: "id",
                    name: "name",
                    description: "description",
                    pictureId: "pictureId",
                    city: "city",
                    rating: 5)
              ]));
      await searchProvider.fetchSearchResult('pizza');

      expect(searchProvider.state, ResultState.hasData);
      expect(searchProvider.result.isNotEmpty, true);
    });

    test('Fetching search result with empty result updates state and message',
        () async {
      when(mockApiService.searchRestaurants('pizza')).thenAnswer(
          (realInvocation) async =>
              SearchResult(error: false, founded: 0, restaurants: []));
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
    });
  });
}
