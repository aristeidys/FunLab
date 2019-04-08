import 'package:flutter/material.dart';
import 'package:funlab/widgets/custom_list_view.dart';

class CustomFutureList<T extends Listable> extends StatelessWidget {
  final Future<List<T>> method;

  CustomFutureList(this.method);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: method,
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? CustomListView(entries: snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
