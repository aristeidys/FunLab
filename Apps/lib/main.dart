import 'package:flutter/material.dart';
import 'package:funlab/common/services/special/check_connectivity_service.dart';
import 'package:funlab/common/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/pages/login.page.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  final String title = 'Fun Lab';

  @override
  Widget build(BuildContext context) {

    // Wrap your MaterialApp in a StoreProvider
    return StoreProvider(
        store: createStore(),
        child: MaterialApp(
            title: title,
            home: Scaffold(
                appBar: AppBar(
                  title: Text(this.title),
                ),
                body: Column(children: <Widget>[CheckConnectivityService(), LoginPage()]) )));
  }
}