// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schemas.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class InventoryItem extends _InventoryItem
    with RealmEntity, RealmObjectBase, RealmObject {
  InventoryItem(
    ObjectId id,
    String goodsDescription,
    int pricePerPiece,
    int quantity,
    String ownerId,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'goodsDescription', goodsDescription);
    RealmObjectBase.set(this, 'pricePerPiece', pricePerPiece);
    RealmObjectBase.set(this, 'quantity', quantity);
    RealmObjectBase.set(this, 'owner_id', ownerId);
  }

  InventoryItem._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get goodsDescription =>
      RealmObjectBase.get<String>(this, 'goodsDescription') as String;
  @override
  set goodsDescription(String value) =>
      RealmObjectBase.set(this, 'goodsDescription', value);

  @override
  int get pricePerPiece =>
      RealmObjectBase.get<int>(this, 'pricePerPiece') as int;
  @override
  set pricePerPiece(int value) =>
      RealmObjectBase.set(this, 'pricePerPiece', value);

  @override
  int get quantity => RealmObjectBase.get<int>(this, 'quantity') as int;
  @override
  set quantity(int value) => RealmObjectBase.set(this, 'quantity', value);

  @override
  String get ownerId => RealmObjectBase.get<String>(this, 'owner_id') as String;
  @override
  set ownerId(String value) => RealmObjectBase.set(this, 'owner_id', value);

  @override
  Stream<RealmObjectChanges<InventoryItem>> get changes =>
      RealmObjectBase.getChanges<InventoryItem>(this);

  @override
  InventoryItem freeze() => RealmObjectBase.freezeObject<InventoryItem>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(InventoryItem._);
    return const SchemaObject(
        ObjectType.realmObject, InventoryItem, 'InventoryItem', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('goodsDescription', RealmPropertyType.string),
      SchemaProperty('pricePerPiece', RealmPropertyType.int),
      SchemaProperty('quantity', RealmPropertyType.int),
      SchemaProperty('ownerId', RealmPropertyType.string, mapTo: 'owner_id'),
    ]);
  }
}
