import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanjibautomobiles/components/widgets.dart';

import '../providers/realm_services.dart';
import '../realm/schemas.dart';
import '../theme.dart';
import 'modify_item.dart';

enum MenuOption { edit, delete }

class TodoItem extends StatelessWidget {
  final InventoryItem item;

  const TodoItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context);
    return item.isValid
        ? ListTile(
            title: Text(item.goodsDescription),
            subtitle: Text(
              "Price: ${item.pricePerPiece},Quantity: ${item.quantity}",
              style: boldTextStyle(),
            ),
            trailing: SizedBox(
              width: 25,
              child: PopupMenuButton<MenuOption>(
                onSelected: (menuItem) =>
                    handleMenuClick(context, menuItem, item, realmServices),
                itemBuilder: (context) => [
                  const PopupMenuItem<MenuOption>(
                    value: MenuOption.edit,
                    child: ListTile(
                        leading: Icon(Icons.edit), title: Text("Edit item")),
                  ),
                  const PopupMenuItem<MenuOption>(
                    value: MenuOption.delete,
                    child: ListTile(
                        leading: Icon(Icons.delete),
                        title: Text("Delete item")),
                  ),
                ],
              ),
            ),
            shape: const Border(bottom: BorderSide()),
          )
        : Container();
  }

  void handleMenuClick(BuildContext context, MenuOption menuItem, InventoryItem item,
      RealmServices realmServices) {
    bool isMine = (item.ownerId == realmServices.currentUser?.id);
    switch (menuItem) {
      case MenuOption.edit:
        if (isMine) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => Wrap(children: [ModifyItemForm(item)]),
          );
        } else {
          errorMessageSnackBar(context, "Edit not allowed!",
                  "You are not allowed to edit tasks \nthat don't belog to you.")
              .show(context);
        }
        break;
      case MenuOption.delete:
        if (isMine) {
          realmServices.deleteItem(item);
        } else {
          errorMessageSnackBar(context, "Delete not allowed!",
                  "You are not allowed to delete tasks \n that don't belog to you.")
              .show(context);
        }
        break;
    }
  }
}
