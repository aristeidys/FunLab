import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/common/models/assignment.model.dart';
import 'package:funlab/common/services/googleApi.service.dart';
import 'package:funlab/common/widgets/buttons/create_button.dart';

class StudentActivityDetail extends StatelessWidget {
  final Activity activity;
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // String firebaseID;
  StudentActivityDetail({Key key, @required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // _firebaseMessaging.getToken().then((token) {
    //   print('FCM Token is $token');
    //   firebaseID = token;
    // });

    return Scaffold(
        appBar: AppBar(
          title: Text('Student: ${activity.title}'),
        ),
        body: Column(
          children: <Widget>[
            Text('Activity title: ${activity.title}'),
            CreateButton('Help', () {
              sendNotification(context);
            })
          ],
        ));
  }

  Future sendNotification(BuildContext context) async {
    final response = await Messaging()
        .sendToAll(title: 'Help', body: 'I need help with ${activity.title}');
    print(response);
    if (response.statusCode != 200) {
      print('${response.statusCode} Failure');
    } else {
      print('Success');
    }
  }
}
