import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/message.model.dart';
import 'package:funlab/common/reducers/app_state.dart';
import 'package:funlab/common/reducers/firebase_identifier_reducer.dart';

class SessionDashboardPage extends StatelessWidget {
  final pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Instructor: Session Dashboard'),
        ),
        body: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[MessagingWidget()]));
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
    return messages.length == 0
        ? Text('Student messages will appear here')
        : ListView(children: messages.map(buildMessage).toList());
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
          messages.add(Message(
              title: notification['title'], body: notification['body']));
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
  }
}
