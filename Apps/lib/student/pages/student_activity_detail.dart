import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/assignment.model.dart';
import 'package:funlab/common/reducers/app_state.dart';
import 'package:funlab/common/services/googleApi.service.dart';
import 'package:funlab/common/widgets/buttons/create_button.dart';

class StudentActivityDetail extends StatelessWidget {
  final Activity activity;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String firebaseID;
  StudentActivityDetail({Key key, @required this.activity}) : super(key: key);

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
                title: Text('Student: ${activity.title}'),
              ),
              body: Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Center(
                    child: CreateButton('Ask Instructor for Help', () {
                      sendNotification(context, username);
                    }),
                  )));
        });
  }

  Future sendNotification(BuildContext context, String username) async {
    final response = await Messaging().sendToAll(
        title: 'A Student needs your Help',
        body: '$username needs help with ${activity.title}',
        senderFCMID: firebaseID,
        username: username);
    print(response);
    if (response.statusCode != 200) {
      print('${response.statusCode} Failure');
    } else {
      print('Success');
    }
  }
}
