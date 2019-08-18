import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:funlab/common/models/message.model.dart';

class MessagingPage extends StatelessWidget {
  final pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Messages'),
        ),
        body: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
          MessagingWidget()
        ]));
  }
}
class MessagingWidget extends StatefulWidget {


  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final List<Message> messages = [];

  @override
  Widget build(BuildContext context) {
    return ListView(children: messages.map(buildMessage).toList());
  }

  Widget buildMessage(Message message) {
    return ListTile(title: Text(message.title), subtitle: Text(message.body));
  }

  @override
  void initState() {
    super.initState();

  _firebaseMessaging.subscribeToTopic('all');

    this.configureFirebase();
  }

  void configureFirebase() {
    _firebaseMessaging.configure(
        onLaunch: (Map<String, dynamic> message) {
          print('onLaunch called $message');
        },
        onResume: (Map<String, dynamic> message) {
          print('onResume called $message');
        },
        onMessage: (Map<String, dynamic> message) {
          print('onMessage called $message');
          final notification = message['notification'];
          setState(() {
            messages.add(Message(title: notification['title'], body: notification['body']));
          });
        },
      );
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