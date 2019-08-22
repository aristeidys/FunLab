import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:funlab/common/models/message.model.dart';
import 'package:funlab/common/widgets/listTile_with_arrow.dart';
import 'package:funlab/common/services/googleApi.service.dart';

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
    return Column(children: <Widget>[
      messages.length == 0
          ? Container(
              margin: EdgeInsets.only(top: 30),
              child: Center(
                child: Text('Student messages will appear here',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
              ))
          : Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new ListTileWithArrow(
                      title: messages[index].title,
                      subTitle: messages[index].body,
                      type: messages[index].type,
                      onTapCallback: () {
                        //
                      },
                    );
                  }))
    ]);
  }

  Widget buildMessage(Message message) {
    return ListTile(title: Text(message.title), subtitle: Text(message.body));
  }

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.subscribeToTopic(Messaging.instructorChannel);
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
        print(message['data']['senderFCMID']);
        
        // uncomment to use fcm id of student
        //  String id = message['data']['senderFCMID'];
        String activityTitle = message['notification']['title'];
        
        String stringType = message['data'][Messaging.messageTypeKey];
        ListTileType messageType = stringType == Messaging.studentDoneValue ? ListTileType.doneTyle : ListTileType.helpTile;
        
        String activityBody = message['notification']['body'];

        setState(() {
          messages.add(Message(title: activityTitle, body: activityBody, type: messageType));
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
