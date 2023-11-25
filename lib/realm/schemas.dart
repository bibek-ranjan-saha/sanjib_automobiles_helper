import 'package:realm/realm.dart';

part 'schemas.g.dart';

@RealmModel()
class _InventoryItem {
  @MapTo('_id')
  @PrimaryKey()
  late ObjectId id;
  late String goodsDescription;
  late int pricePerPiece;
  late int quantity;
  @MapTo('owner_id')
  late String ownerId;
}
