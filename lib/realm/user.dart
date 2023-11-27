import 'package:realm/realm.dart';

part 'user.g.dart';

@RealmModel()
class _User {
  @MapTo('_id')
  @PrimaryKey()
  late ObjectId id;
  late String? allowedOwners;
  late String? shopName;
  late String? shopImage;
  @MapTo('owner_id')
  late String ownerId;
}
