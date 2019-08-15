import 'package:flutter/material.dart';


// Listable entities can be decoded and presented as a List

abstract class Listable {
  Widget buildListTile();
  Listable fromJson(Map<String, dynamic> json){}
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
