import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/task.model.dart';
import 'package:funlab/common/reducers/app_state.dart';
import 'package:funlab/common/services/googleApi.service.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/buttons/create_button.dart';
import 'package:funlab/common/widgets/buttons/edit_button.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:http/http.dart';

class StudentTaskDetail extends StatefulWidget {
  final Task task;

  StudentTaskDetail({Key key, @required this.task}) : super(key: key);

  @override
  _StudentTaskDetailState createState() => _StudentTaskDetailState();
}

class _StudentTaskDetailState extends State<StudentTaskDetail> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String firebaseID;

  @override
  Widget build(BuildContext context) {
    _firebaseMessaging.getToken().then((token) {
      print('FCM Token is $token');
      firebaseID = token;
    });

    return StoreConnector<AppState, String>(
        converter: (store) => store.state.username,
        builder: (context, username) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Styles.studentMainColor,
                title: Text('Task: ${widget.task.title}'),
              ),
              body: Builder(
                  builder: (context) => Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            CreateButton('I need Help!', () async {
                              Response response =
                                  await sendHelpNotification(context, username);

                              CustomToaster().showDefaultToast(response, context);
                            }),
                            EditButton(text: 'I am Done!', callback: () async {
                              Response response =
                                  await sendDoneNotification(context, username);

                              CustomToaster().showDefaultToast(response, context);
                            })
                          ],
                        ),
                      ))));
        });
  }

  Future<Response> sendHelpNotification(
      BuildContext context, String username) async {
    return await Messaging().sendToTopic(
        title: 'A Student needs your Help',
        body: '$username needs help on ${widget.task.title}',
        type: Messaging.messageTypeStudentHelp,
        topic: Messaging.instructorChannel,
        senderFCMID: firebaseID,
        username: username,
        taskId: widget.task.id);
  }

  Future sendDoneNotification(BuildContext context, String username) async {
    return await Messaging().sendToTopic(
        title: 'A Student finished a Task',
        body: '$username finished ${widget.task.title}',
        type: Messaging.messageTypeStudentDone,
        topic: Messaging.instructorChannel,
        senderFCMID: firebaseID,
        username: username,
        taskId: widget.task.id);
  }
}
