import 'package:flutter/material.dart';
import 'package:funlab/pages/home_page.dart';
import 'package:funlab/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  final String title = 'Fun Lab';

  @override
  Widget build(BuildContext context) {

_firebaseMessaging.requestNotificationPermissions();
_firebaseMessaging.configure(onLaunch: 
  (Map<String, dynamic> message) async {
    print("on Message: $message");
  }
);
  

    // Wrap your MaterialApp in a StoreProvider
    return StoreProvider(
        store: createStore(),
        child: MaterialApp(
            title: title,
            home: Scaffold(
                appBar: AppBar(
                  title: Text(this.title),
                ),
                body: new HomePage())));
  }
}
