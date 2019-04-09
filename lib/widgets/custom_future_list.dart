import 'package:flutter/material.dart';
import 'package:funlab/models/lab_session.model.dart';
import 'package:funlab/services/service.dart';
import 'package:funlab/widgets/custom_list_view.dart';

class CustomFutureList<T extends Listable> extends StatelessWidget {

  Future callback;

  CustomFutureList(this.callback);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LabSession>>(
      future: callback,
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? CustomListView(entries: snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
