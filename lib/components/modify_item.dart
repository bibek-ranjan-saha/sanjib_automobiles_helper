import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanjibautomobiles/components/widgets.dart';
import 'package:sanjibautomobiles/utils/extensions.dart';

import '../providers/realm_services.dart';
import '../realm/inventory_item.dart';

class ModifyItemForm extends StatefulWidget {
  final InventoryItem item;

  const ModifyItemForm(this.item, {Key? key}) : super(key: key);

  @override
  _ModifyItemFormState createState() => _ModifyItemFormState(item);
}

class _ModifyItemFormState extends State<ModifyItemForm> {
  final _formKey = GlobalKey<FormState>();
  final InventoryItem item;
  late TextEditingController _itemDescriptionController;
  late TextEditingController _itemPriceController;
  late TextEditingController _itemQuantityController;

  _ModifyItemFormState(this.item);

  @override
  void initState() {
    _itemDescriptionController =
        TextEditingController(text: item.goodsDescription);
    _itemPriceController =
        TextEditingController(text: item.pricePerPiece.toString());
    _itemQuantityController =
        TextEditingController(text: item.quantity.toString());

    super.initState();
  }

  @override
  void dispose() {
    _itemQuantityController.dispose();
    _itemDescriptionController.dispose();
    _itemPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    final realmServices = Provider.of<RealmServices>(context, listen: false);
    return formLayout(
        context,
        Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Update your product", style: myTextTheme.headline6),
                TextFormField(
                  controller: _itemDescriptionController,
                  validator: (value) => (value ?? "").isEmpty
                      ? "Please enter new description"
                      : null,
                ),
                TextFormField(
                  controller: _itemPriceController,
                  validator: (value) => (value ?? "").isEmpty
                      ? "Please enter new price per piece"
                      : null,
                ),
                TextFormField(
                  controller: _itemQuantityController,
                  validator: (value) => (value ?? "").isEmpty
                      ? "Please enter new quantity available"
                      : null,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey),
                          child: const Text("Cancel")),
                      20.horizontalSpace(),
                      Consumer<RealmServices>(
                          builder: (context, realmServices, child) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            onPressed: () async {
                              final description = _itemPriceController.text;
                              final price =
                                  int.tryParse(_itemPriceController.text) ?? 0;
                              final quantity =
                                  int.tryParse(_itemQuantityController.text) ??
                                      0;
                              await update(context, realmServices, item,
                                  description, price, quantity);
                            },
                            child: const Text("Update"));
                      }),
                    ],
                  ),
                ),
              ],
            )));
  }

  Future<void> update(
      BuildContext context,
      RealmServices realmServices,
      InventoryItem item,
      String description,
      int pricePerPiece,
      int quantity) async {
    if (_formKey.currentState!.validate()) {
      await realmServices.updateItem(item,
          description: description,
          pricePerPiece: pricePerPiece,
          quantity: quantity);
      Navigator.pop(context);
    }
  }

  void delete(
      RealmServices realmServices, InventoryItem item, BuildContext context) {
    realmServices.deleteItem(item);
    Navigator.pop(context);
  }
}
