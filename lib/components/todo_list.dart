import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';
import 'package:sanjibautomobiles/components/todo_item.dart';
import 'package:sanjibautomobiles/components/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../providers/realm_services.dart';
import '../realm/schemas.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context);
    return Stack(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: StreamBuilder<RealmResultsChanges<InventoryItem>>(
              stream: realmServices.realm
                  .query<InventoryItem>("TRUEPREDICATE SORT(_id ASC)")
                  .changes,
              builder: (context, snapshot) {
                final data = snapshot.data;

                if (data == null) return waitingIndicator();

                final results = data.results;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: results.realm.isClosed ? 0 : results.length,
                  itemBuilder: (context, index) => results[index].isValid
                      ? TodoItem(results[index])
                      : const Center(child: Text("No Products availble")),
                );
              },
            ),
          ),
        ),
        realmServices.isWaiting ? waitingIndicator() : Container(),
      ],
    );
  }
}
