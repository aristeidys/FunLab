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
  static const studentDoneValue = 'student_done';
  
  static const studentHelpValue = 'student_help';

  Future<Response> sendToTopic({
    @required String title,
    @required String body,
    @required String type,
    @required String senderFCMID,
    @required String username,
    @required String topic,
  }) {
    return sendTo(
        title: title,
        body: body,
        type: type,
        senderFCMID: senderFCMID,
        username: username,
        topic: '/topics/$topic');
  }

  Future<Response> sendTo({
    @required String title,
    @required String body,
    @required String type,
    @required String senderFCMID,
    @required String username,
    @required String topic,
  }) {
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
            messageTypeKey:type // type of the notification
          },
          'to': '$topic',
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        });
  }
}
