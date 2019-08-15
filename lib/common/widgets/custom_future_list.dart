import 'package:flutter/material.dart';
import 'package:funlab/common/widgets/custom_list_view.dart';

class CustomFutureList<T extends Listable> extends StatelessWidget {

  final Future callback;

  CustomFutureList(this.callback);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: callback,
      builder: (context, snapshot) {

        return snapshot.hasData
            ? CustomListView(entries: snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
