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

  final List<StudentMessage> messages = [];

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
                          child: messages[index].type == ListTileType.doneTile
                              ? InstructorDoneListTile(
                                  title: messages[index].title,
                                  subTitle: messages[index].body,
                                )
                              : InstructorHelpListTile(
                                  title: messages[index].title,
                                  subTitle: messages[index].body,
                                )),
                      secondaryActions: <Widget>[
                        IconSlideAction(
                            caption: 'Confirm',
                            color: Colors.green,
                            icon: Icons.done,
                            onTap: () async {
                              Response response =
                                  await sendTaskConfirmed(index);

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
                            Response response = await sendTaskReject(index);

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

  Future<Response> sendTaskConfirmed(int index) async {
    Response response = await Messaging().sendToToken(
        type: Messaging.messageTypeInstructorConfirm,
        title: 'Task confirmed',
        body: 'Your Instrucor Confirmed your task.',
        token: messages[index].studentToken,
        taskId: messages[index].taskId);
    return response;
  }

    Future<Response> sendTaskPass(int index) async {
    Response response = await Messaging().sendToToken(
        type: Messaging.messageTypeInstructorConfirm,
        title: 'Task confirmed',
        body: 'Your Instrucor Confirmed your task.',
        token: messages[index].studentToken,
        taskId: messages[index].taskId);
    return response;
  }

  Future<Response> sendTaskReject(int index) async {
    Response response = await Messaging().sendToToken(
        type: Messaging.messageTypeInstructorReject,
        title: 'Task rejected',
        body: 'Your Instrucor rejected your task.',
        token: messages[index].studentToken,
        taskId: messages[index].taskId);
    return response;
  }

  Widget buildMessage(StudentMessage message) {
    return ListTile(title: Text(message.title), subtitle: Text(message.body));
  }

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.subscribeToTopic(Messaging.instructorChannel);
    this.configureFirebase();
  }

  @override
  void dispose() {
    _firebaseMessaging.unsubscribeFromTopic(Messaging.instructorChannel);
    super.dispose();
  }

  void configureFirebase() {
    _firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch called $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume called $message');
      },
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage called for Instructor $message');

        // uncomment to use fcm id of student
        //  String id = message['data']['senderFCMID'];
        String taskTitle = message['notification']['title'];

        String stringType = message['data'][Messaging.messageTypeKey];
        String studentToken = message['data'][Messaging.messageStudentTokenKey];
        int taskId = int.parse(message['data'][Messaging.taskIdKey]);

        ListTileType messageType =
            stringType == Messaging.messageTypeStudentDone
                ? ListTileType.doneTile
                : ListTileType.helpTile;

        String taskBody = message['notification']['body'];

        setState(() {
          messages.add(StudentMessage(
              title: taskTitle,
              body: taskBody,
              studentToken: studentToken,
              type: messageType,
              taskId: taskId));
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
