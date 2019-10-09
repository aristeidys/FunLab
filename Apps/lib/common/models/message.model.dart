import 'dart:convert';

import 'package:flutter/material.dart';

class FirebaseMessage {
  final String title;
  final String body;
  final String type;
  final int senderID;
  final String senderToken;
  final String recipient;
  final int taskID;

  FirebaseMessage(
      {@required this.title,
      @required this.body,
      @required this.type,
      this.senderID,
      this.senderToken,
      this.recipient,
      @required this.taskID});

  FirebaseMessage enrollmentFromJson(String str) {
    final jsonData = json.decode(str);
    return FirebaseMessage.fromJson(jsonData);
  }

  factory FirebaseMessage.fromJson(Map<String, dynamic> json) =>
      FirebaseMessage(
        title: json['notification']['title'],
        body: json['notification']['body'],
        type: json['data']['type'],
        senderToken: json['data']['senderToken'],
        senderID: int.parse(json['data']['senderID']) ?? 0,
        taskID: int.parse(json['data']['taskID']) ?? 0,
      );
}
