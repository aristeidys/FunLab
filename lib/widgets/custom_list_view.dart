import 'package:flutter/material.dart';

abstract class Listable {
  Widget buildListTile();
}

class CustomListView<T extends Listable> extends StatelessWidget {
  final List<T> entries;

  CustomListView({Key key, this.entries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: entries.length,
            padding: const EdgeInsets.all(15.0),
            itemBuilder: (context, position) {
              return Column(children: <Widget>[
                Divider(height: 5.0),
                entries[position].buildListTile()
              ]);
            }));
  }
}