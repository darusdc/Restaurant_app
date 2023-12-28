// Mocks generated by Mockito 5.4.4 from annotations
// in resto_mana/test/provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:resto_mana/data/api/api_service.dart' as _i3;
import 'package:resto_mana/data/models/restaurant.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeRestaurantListResult_0 extends _i1.SmartFake
    implements _i2.RestaurantListResult {
  _FakeRestaurantListResult_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDetailRestaurantResult_1 extends _i1.SmartFake
    implements _i2.DetailRestaurantResult {
  _FakeDetailRestaurantResult_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCustomerReview_2 extends _i1.SmartFake
    implements _i2.CustomerReview {
  _FakeCustomerReview_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSearchResult_3 extends _i1.SmartFake implements _i2.SearchResult {
  _FakeSearchResult_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ApiService].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiService extends _i1.Mock implements _i3.ApiService {
  @override
  _i4.Future<_i2.RestaurantListResult> restaurantList() => (super.noSuchMethod(
        Invocation.method(
          #restaurantList,
          [],
        ),
        returnValue: _i4.Future<_i2.RestaurantListResult>.value(
            _FakeRestaurantListResult_0(
          this,
          Invocation.method(
            #restaurantList,
            [],
          ),
        )),
        returnValueForMissingStub: _i4.Future<_i2.RestaurantListResult>.value(
            _FakeRestaurantListResult_0(
          this,
          Invocation.method(
            #restaurantList,
            [],
          ),
        )),
      ) as _i4.Future<_i2.RestaurantListResult>);

  @override
  _i4.Future<_i2.DetailRestaurantResult> detailRestaurant(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #detailRestaurant,
          [id],
        ),
        returnValue: _i4.Future<_i2.DetailRestaurantResult>.value(
            _FakeDetailRestaurantResult_1(
          this,
          Invocation.method(
            #detailRestaurant,
            [id],
          ),
        )),
        returnValueForMissingStub: _i4.Future<_i2.DetailRestaurantResult>.value(
            _FakeDetailRestaurantResult_1(
          this,
          Invocation.method(
            #detailRestaurant,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.DetailRestaurantResult>);

  @override
  _i4.Future<_i2.CustomerReview> postReview(
    String? reviewText,
    String? id,
    String? name,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #postReview,
          [
            reviewText,
            id,
            name,
          ],
        ),
        returnValue: _i4.Future<_i2.CustomerReview>.value(_FakeCustomerReview_2(
          this,
          Invocation.method(
            #postReview,
            [
              reviewText,
              id,
              name,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.CustomerReview>.value(_FakeCustomerReview_2(
          this,
          Invocation.method(
            #postReview,
            [
              reviewText,
              id,
              name,
            ],
          ),
        )),
      ) as _i4.Future<_i2.CustomerReview>);

  @override
  _i4.Future<_i2.SearchResult> searchRestaurants(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchRestaurants,
          [query],
        ),
        returnValue: _i4.Future<_i2.SearchResult>.value(_FakeSearchResult_3(
          this,
          Invocation.method(
            #searchRestaurants,
            [query],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.SearchResult>.value(_FakeSearchResult_3(
          this,
          Invocation.method(
            #searchRestaurants,
            [query],
          ),
        )),
      ) as _i4.Future<_i2.SearchResult>);
}
