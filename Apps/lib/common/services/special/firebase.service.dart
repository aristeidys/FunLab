import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:funlab/common/models/message.model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class FireBaseService {
  final String serverKey =
      'AAAAJ9-AIHc:APA91bHDQHh9ymEKv2vzivi2dYB9Dl6ij5UmgG1uRt9MK99Cr7TpRK7WPWcPbqC5uLu2ozYrkAoacHkzuom1ckpHBC8ye-mUuDzYHGBerMX9I09DCfruyDmX8IEihPz5ToRTzuQxJI_a';
  final String endpoint = 'https://fcm.googleapis.com/fcm/send';

  Future<Response> send({@required FirebaseMessage message}) {
    print('Post to Google Maps');
    return http.Client().post(endpoint,
        body: jsonEncode({
          'notification': {
            'body': '${message.body}',
            'title': '${message.title}'
          },
          'priority': 'high',
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',

            // data here
            'type': message.type,
            'senderID': message.senderID,
            'senderToken': message.senderToken,
            'taskID': message.taskID
          },
          'to': message.recipient,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        });
  }
}
