import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:funlab/common/services/special/response.dart';

Session sessionFromJson(String str) {
  final jsonData = json.decode(str);
  return Session.fromJson(jsonData);
}

String sessionToJson(Session data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

List<Session> allSessionsFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Session>.from(jsonData.map((x) => Session.fromJson(x)));
}

String allSessionsToJson(List<Session> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Session {
  int id;
  String title;
  String description;
  String status;
  int classroomID;

  Session(
      {this.id, this.title, this.description, this.status, this.classroomID});

  factory Session.fromJson(Map<String, dynamic> json) => new Session(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        description: json["description"],
        classroomID: json["classroom_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "status": status,
        "description": description,
        "classroom_id": classroomID,
      };

  static Response<List<Session>> sessionsResponseFromJson(
      http.Response response) {
    if (response.statusCode == Config.getSuccess) {
      List<Session> sessions = allSessionsFromJson(response.body);
      if (sessions.length == 0) {
        return Response(null, 'No Sessions found');
      } else {
        return Response(sessions, null);
      }
    } else {
      return Response(null, response.body);
    }
  }
}
