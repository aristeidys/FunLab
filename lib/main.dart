// main.dart
import 'package:flutter/material.dart';
import 'package:funlab/pages/home_page.dart';
import 'package:funlab/store.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
        home: HomePage(title),
      ),
    );
  }
}
