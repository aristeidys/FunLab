import 'package:flutter/material.dart';
import 'package:funlab/common/pages/role_selection_page.dart';
import 'package:funlab/common/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  final String title = 'Fun Lab';

  @override
  Widget build(BuildContext context) {
  
    //configureFirebase();
    // Wrap your MaterialApp in a StoreProvider
    return StoreProvider(
        store: createStore(),
        child: MaterialApp(
            title: title,
            home: Scaffold(
                appBar: AppBar(
                  title: Text(this.title),
                ),
                body: new RoleSelectionPage())));
  }


  void configureFirebase() {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.configure(
        onLaunch: (Map<String, dynamic> message) {
          print('onLaunch called $message');
        },
        onResume: (Map<String, dynamic> message) {
          print('onResume called $message');
        },
        onMessage: (Map<String, dynamic> message) {
          print('onMessage called $message');
        },
      );
    _firebaseMessaging.subscribeToTopic('student');
    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(
      sound: true,
      badge: true,
      alert: true,
    ));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print('Hello');
    });
    _firebaseMessaging.getToken().then((token) {
      print('FCM Token is $token'); // Print the Token in Console
    });
  }
}
