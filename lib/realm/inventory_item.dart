import 'package:realm/realm.dart';

part 'inventory_item.g.dart';

@RealmModel()
class _InventoryItem {
  @MapTo('_id')
  @PrimaryKey()
  late ObjectId id;
  late String goodsDescription;
  late int pricePerPiece;
  late int quantity;
  late String? qrCode;
  late String? productImage;
  bool isDeleted = false;
  @MapTo('owner_id')
  late String ownerId;
}