import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Messaging {
  // from https://console.firebase.google.com
  // project settings --> cloud messaging --> Server key
  static const String serverKey =
      'AAAAJ9-AIHc:APA91bHDQHh9ymEKv2vzivi2dYB9Dl6ij5UmgG1uRt9MK99Cr7TpRK7WPWcPbqC5uLu2ozYrkAoacHkzuom1ckpHBC8ye-mUuDzYHGBerMX9I09DCfruyDmX8IEihPz5ToRTzuQxJI_a';

  Future<Response> sendToAll(
      {@required String title,
      @required String body,
      @required String senderFCMID,
      @required String username}) {
    return sendToTopic(
        title: title, body: body, senderFCMID: senderFCMID, username: username, topic: 'all');
  }

  Future<Response> sendToTopic({
    @required String title,
    @required String body,
    @required String senderFCMID,
    @required String username,
    @required String topic,
  }) {
    return sendTo(
        title: title,
        body: body,
        senderFCMID: senderFCMID,
        username: username,
        fcmToken: '/topics/$topic');
  }

  Future<Response> sendTo({
    @required String title,
    @required String body,
    @required String senderFCMID,
    @required String username,
    @required String fcmToken,
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
            'senderFCMID': senderFCMID,
            'senderUsername': username
          },
          'to': '$fcmToken',
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        });
  }
}
