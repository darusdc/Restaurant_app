// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_restaurant_realm.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class FavoriteRestaurant extends _FavoriteRestaurant
    with RealmEntity, RealmObjectBase, RealmObject {
  FavoriteRestaurant(
    ObjectId id,
    String idUser, {
    Iterable<String> idProducts = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'idUser', idUser);
    RealmObjectBase.set<RealmList<String>>(
        this, 'idProducts', RealmList<String>(idProducts));
  }

  FavoriteRestaurant._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get idUser => RealmObjectBase.get<String>(this, 'idUser') as String;
  @override
  set idUser(String value) => RealmObjectBase.set(this, 'idUser', value);

  @override
  RealmList<String> get idProducts =>
      RealmObjectBase.get<String>(this, 'idProducts') as RealmList<String>;
  @override
  set idProducts(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<FavoriteRestaurant>> get changes =>
      RealmObjectBase.getChanges<FavoriteRestaurant>(this);

  @override
  FavoriteRestaurant freeze() =>
      RealmObjectBase.freezeObject<FavoriteRestaurant>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(FavoriteRestaurant._);
    return const SchemaObject(
        ObjectType.realmObject, FavoriteRestaurant, 'FavoriteRestaurant', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('idUser', RealmPropertyType.string),
      SchemaProperty('idProducts', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
    ]);
  }
}
