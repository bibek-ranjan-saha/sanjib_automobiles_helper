import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanjibautomobiles/components/widgets.dart';
import 'package:sanjibautomobiles/utils/extensions.dart';

import '../providers/realm_services.dart';

class CreateItemAction extends StatelessWidget {
  const CreateItemAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return styledFloatingAddButton(context,
        onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
              clipBehavior: Clip.hardEdge,
              context: context,
              builder: (_) => const Wrap(children: [CreateItemForm()]),
            ));
  }
}

class CreateItemForm extends StatefulWidget {
  const CreateItemForm({Key? key}) : super(key: key);

  @override
  createState() => _CreateItemFormState();
}

class _CreateItemFormState extends State<CreateItemForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _itemDescriptionController;
  late TextEditingController _itemPriceController;
  late TextEditingController _itemQuantityController;

  @override
  void initState() {
    _itemDescriptionController = TextEditingController();
    _itemPriceController = TextEditingController();
    _itemQuantityController = TextEditingController();
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
    TextTheme theme = Theme.of(context).textTheme;
    return formLayout(
        context,
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Create a new Product", style: theme.titleLarge),
              TextFormField(
                controller: _itemDescriptionController,
                decoration: const InputDecoration(hintText: "Description"),
                validator: (value) => (value ?? "").isEmpty
                    ? "Please enter goods description"
                    : null,
              ),
              10.verticalSpace(),
              TextFormField(
                controller: _itemPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "Price per piece"),
                validator: (value) => (value ?? "").isEmpty
                    ? "Please enter price per piece"
                    : null,
              ),
              10.verticalSpace(),
              TextFormField(
                controller: _itemQuantityController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(hintText: "Quantity available"),
                validator: (value) => (value ?? "").isEmpty
                    ? "Please enter quantity available"
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
                          onPressed: () => save(realmServices, context),
                          child: const Text("Create"));
                    }),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void save(RealmServices realmServices, BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final description = _itemDescriptionController.text;
      final price = int.tryParse(_itemPriceController.text) ?? 0;
      final quantity = int.tryParse(_itemQuantityController.text) ?? 0;
      realmServices.createItem(description, price, quantity);
      Navigator.pop(context);
    }
  }
}
