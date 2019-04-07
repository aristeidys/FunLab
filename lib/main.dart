// main.dart
import 'package:flutter/material.dart';
import 'package:funlab/models/app_state.dart';
import 'package:funlab/pages/home_page.dart';
import 'package:redux/redux.dart';                              // new
import 'package:flutter_redux/flutter_redux.dart';              // new
import 'package:redux_logging/redux_logging.dart';
import 'package:funlab/reducers/app_reducer.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  final String title = 'Fun Lab';
    //
    // Store is just a class that holds your apps State tree.
    // AppState is something that we will (but haven't yet) established
  final store = Store<AppState>(                            // new
    appReducer,                                                 // new
    initialState: AppState(),                               // new
    middleware: [LoggingMiddleware.printer()],  
  );

  @override
  Widget build(BuildContext context) {
    // Wrap your MaterialApp in a StoreProvider
    return StoreProvider(                                   // new
      store: store,                                             // new
      child: MaterialApp(
          title: title,
          home: HomePage(title),
      ),
    );
  }
}