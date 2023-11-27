import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import '../realm/inventory_item.dart';

class RealmServices with ChangeNotifier {
  static const String queryAllName = "getAllItemsSubscription";
  static const String queryMyItemsName = "getMyItemsSubscription";

  bool showAll = false;
  bool offlineModeOn = false;
  bool isWaiting = false;
  late Realm realm;
  User? currentUser;
  App app;

  RealmServices(this.app) {
    if (app.currentUser != null || currentUser != app.currentUser) {
      currentUser ??= app.currentUser;
      realm = Realm(
          Configuration.flexibleSync(currentUser!, [InventoryItem.schema]));
      showAll = (realm.subscriptions.findByName(queryAllName) != null);
      if (realm.subscriptions.isEmpty) {
        updateSubscriptions();
      }
    }
  }

  Future<void> updateSubscriptions() async {
    realm.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.clear();
      if (showAll) {
        mutableSubscriptions.add(realm.all<InventoryItem>(),
            name: queryAllName);
      } else {
        mutableSubscriptions.add(
            realm.query<InventoryItem>(r'owner_id == $0', [currentUser?.id]),
            name: queryMyItemsName);
      }
    });
    await realm.subscriptions.waitForSynchronization();
  }

  Future<void> sessionSwitch() async {
    offlineModeOn = !offlineModeOn;
    if (offlineModeOn) {
      realm.syncSession.pause();
    } else {
      try {
        isWaiting = true;
        notifyListeners();
        realm.syncSession.resume();
        await updateSubscriptions();
      } finally {
        isWaiting = false;
      }
    }
    notifyListeners();
  }

  Future<void> switchSubscription(bool value) async {
    showAll = value;
    if (!offlineModeOn) {
      try {
        isWaiting = true;
        notifyListeners();
        await updateSubscriptions();
      } finally {
        isWaiting = false;
      }
    }
    notifyListeners();
  }

  void createItem(String description, int pricePerPiece, int initialQuantity) {
    final newItem = InventoryItem(
      ObjectId(),
      description,
      pricePerPiece,
      initialQuantity,
      currentUser!.id,
    );
    realm.write<InventoryItem>(() => realm.add<InventoryItem>(newItem));
    notifyListeners();
  }

  void deleteItem(InventoryItem item) {
    realm.write(() => realm.delete(item));
    notifyListeners();
  }

  Future<void> updateItem(InventoryItem item,
      {String? description, int? pricePerPiece, int? quantity}) async {
    realm.write(() {
      if (description != null) {
        item.goodsDescription = description;
      }
      if (pricePerPiece != null) {
        item.pricePerPiece = pricePerPiece;
      }
      if (quantity != null) {
        item.quantity = quantity;
      }
    });
    notifyListeners();
  }

  Future<void> close() async {
    if (currentUser != null) {
      await currentUser?.logOut();
      currentUser = null;
    }
    realm.close();
  }

  @override
  void dispose() {
    realm.close();
    super.dispose();
  }
}
