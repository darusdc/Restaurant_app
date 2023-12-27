import 'package:realm/realm.dart';
part 'favorite_restaurant_realm.g.dart';

@RealmModel()
class _FavoriteRestaurant {
  @PrimaryKey()
  late ObjectId id;

  late String idUser;
  late List<String> idProducts;
}
