// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class User extends _User with RealmEntity, RealmObjectBase, RealmObject {
  User(
    ObjectId id,
    String ownerId, {
    String? allowedOwners,
    String? shopName,
    String? shopImage,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'allowedOwners', allowedOwners);
    RealmObjectBase.set(this, 'shopName', shopName);
    RealmObjectBase.set(this, 'shopImage', shopImage);
    RealmObjectBase.set(this, 'owner_id', ownerId);
  }

  User._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String? get allowedOwners =>
      RealmObjectBase.get<String>(this, 'allowedOwners') as String?;
  @override
  set allowedOwners(String? value) =>
      RealmObjectBase.set(this, 'allowedOwners', value);

  @override
  String? get shopName =>
      RealmObjectBase.get<String>(this, 'shopName') as String?;
  @override
  set shopName(String? value) => RealmObjectBase.set(this, 'shopName', value);

  @override
  String? get shopImage =>
      RealmObjectBase.get<String>(this, 'shopImage') as String?;
  @override
  set shopImage(String? value) => RealmObjectBase.set(this, 'shopImage', value);

  @override
  String get ownerId => RealmObjectBase.get<String>(this, 'owner_id') as String;
  @override
  set ownerId(String value) => RealmObjectBase.set(this, 'owner_id', value);

  @override
  Stream<RealmObjectChanges<User>> get changes =>
      RealmObjectBase.getChanges<User>(this);

  @override
  User freeze() => RealmObjectBase.freezeObject<User>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(User._);
    return const SchemaObject(ObjectType.realmObject, User, 'User', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('allowedOwners', RealmPropertyType.string, optional: true),
      SchemaProperty('shopName', RealmPropertyType.string, optional: true),
      SchemaProperty('shopImage', RealmPropertyType.string, optional: true),
      SchemaProperty('ownerId', RealmPropertyType.string, mapTo: 'owner_id'),
    ]);
  }
}
