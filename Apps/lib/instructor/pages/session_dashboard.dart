import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:funlab/common/models/message.model.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/common/widgets/listTile_with_arrow.dart';
import 'package:funlab/common/services/googleApi.service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart';

class SessionDashboardPage extends StatelessWidget {
  final pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.instructorColor,
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
                child: Text('Student messages will appear here'),
              ))
          : Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: Container(
                          color: Colors.white,
                          child: ListTileWithArrow(
                            title: messages[index].title,
                            subTitle: messages[index].body,
                            type: messages[index].type,
                            onTapCallback: () {
                              // on tap
                            },
                          )),
                      secondaryActions: <Widget>[
                        IconSlideAction(
                            caption: 'Confirm',
                            color: Colors.green,
                            icon: Icons.done,
                            onTap: () async {
                              Response response = await sendActivityConfirmed(index);

                              if (response.statusCode == 200) {
                                setState(() {
                                  messages.removeAt(index);
                                });
                              }
                              CustomToaster()
                                  .showDefaultToast(response, context);
                            }),
                        IconSlideAction(
                          caption: 'Reject',
                          color: Colors.red,
                          icon: Icons.cancel,
                          onTap: () async {
                            Response response = await sendActivityReject(index);

                            if (response.statusCode == 200) {
                              setState(() {
                                messages.removeAt(index);
                              });
                            }
                            CustomToaster().showDefaultToast(response, context);
                          },
                        ),
                      ],
                    );
                  }))
    ]);
  }

  Future<Response> sendActivityConfirmed(int index) async {
    Response response = await Messaging().sendToTopic(
        type: Messaging.messageTypeInstructorConfirm,
        title: 'Activity confirmed',
        body:
            'Your Instrucor Confirmed your activity.',
        topic: Messaging.studentChannel,
        username: '',
        senderFCMID: '',
        activityId: messages[index].activityId);
    return response;
  }

  Future<Response> sendActivityReject(int index) async {
    Response response = await Messaging().sendToTopic(
        type: Messaging.messageTypeInstructorReject,
        title: 'Activity rejected',
        body: 'Your Instrucor rejected your activity.',
        topic: Messaging.studentChannel,
        username: '',
        senderFCMID: '',
        activityId: messages[index].activityId);
    return response;
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
        int activityId = message['data'][Messaging.activityIdKey];

        ListTileType messageType = stringType == Messaging.messageTypeStudentDone
            ? ListTileType.doneTyle
            : ListTileType.helpTile;

        String activityBody = message['notification']['body'];

        setState(() {
          messages.add(Message(
              title: activityTitle, body: activityBody, type: messageType, activityId: activityId));
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
