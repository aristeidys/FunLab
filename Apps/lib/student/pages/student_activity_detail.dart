import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/assignment.model.dart';
import 'package:funlab/common/reducers/app_state.dart';
import 'package:funlab/common/services/googleApi.service.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/buttons/create_button.dart';
import 'package:funlab/common/widgets/buttons/edit_button.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:http/http.dart';

class StudentActivityDetail extends StatefulWidget {
  final Activity activity;

  StudentActivityDetail({Key key, @required this.activity}) : super(key: key);

  @override
  _StudentActivityDetailState createState() => _StudentActivityDetailState();
}

class _StudentActivityDetailState extends State<StudentActivityDetail> {
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
                title: Text('Student: ${widget.activity.title}'),
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
        body: '$username needs help with activity: ${widget.activity.title}',
        type: Messaging.studentHelpValue,
        topic: Messaging.instructorChannel,
        senderFCMID: firebaseID,
        username: username);
  }

  Future sendDoneNotification(BuildContext context, String username) async {
    return await Messaging().sendToTopic(
        title: 'A Student finished an Activity',
        body: '$username finished activity: ${widget.activity.title}',
        type: Messaging.studentDoneValue,
        topic: Messaging.instructorChannel,
        senderFCMID: firebaseID,
        username: username);
  }
}
