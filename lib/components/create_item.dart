import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanjibautomobiles/components/widgets.dart';

import '../providers/realm_services.dart';

class CreateItemAction extends StatelessWidget {
  const CreateItemAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return styledFloatingAddButton(context,
        onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
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
              Text("Create a new item", style: theme.headline6),
              TextFormField(
                controller: _itemDescriptionController,
                validator: (value) => (value ?? "").isEmpty
                    ? "Please enter goods description"
                    : null,
              ),
              TextFormField(
                controller: _itemPriceController,
                validator: (value) => (value ?? "").isEmpty
                    ? "Please enter price per piece"
                    : null,
              ),
              TextFormField(
                controller: _itemQuantityController,
                validator: (value) => (value ?? "").isEmpty
                    ? "Please enter quantity available"
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cancelButton(context),
                    Consumer<RealmServices>(
                        builder: (context, realmServices, child) {
                      return okButton(context, "Create",
                          onPressed: () => save(realmServices, context));
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
