import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Messaging {
  // from https://console.firebase.google.com
  // project settings --> cloud messaging --> Server key
  static const String serverKey =
      'AAAAJ9-AIHc:APA91bHDQHh9ymEKv2vzivi2dYB9Dl6ij5UmgG1uRt9MK99Cr7TpRK7WPWcPbqC5uLu2ozYrkAoacHkzuom1ckpHBC8ye-mUuDzYHGBerMX9I09DCfruyDmX8IEihPz5ToRTzuQxJI_a';

  // channels
  static const studentChannel = 'studentChannel';
  static const instructorChannel = 'instructorChannel';

  static const messageTypeKey = 'type';
  static const activityIdKey = 'activityId';

  static const messageTypeStudentDone = 'student_done';
  static const messageTypeStudentHelp = 'student_help';
  static const messageTypeInstructorConfirm = 'instructor_confirm';
  static const messageTypeInstructorReject = 'instructor_reject';

  static const messageStudentTokenKey = 'senderFCMID';

  Future<Response> sendToToken(
      {@required String title,
      @required String body,
      @required String type,
      @required String token,
      @required int activityId}) {
    print('Post to Google Maps');
    return http.Client().post('https://fcm.googleapis.com/fcm/send',
        body: jsonEncode({
          'notification': {'body': '$body', 'title': '$title'},
          'priority': 'high',
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',

            // sent data here
            'type': type, // type of the notification
            'activityId': activityId
          },
          'to': token,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        });
  }

  Future<Response> sendToTopic(
      {@required String title,
      @required String body,
      @required String type,
      @required String senderFCMID,
      @required String username,
      @required String topic,
      @required int activityId}) {
    print('Post to Google Maps');
    return http.Client().post('https://fcm.googleapis.com/fcm/send',
        body: jsonEncode({
          'notification': {'body': '$body', 'title': '$title'},
          'priority': 'high',
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',

            // sent data here
            'senderFCMID': senderFCMID, // sender fcm id
            'senderUsername': username, // sender username
            'type': type, // type of the notification
            'activityId': activityId
          },
          'to': '/topics/$topic',
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        });
  }
}
