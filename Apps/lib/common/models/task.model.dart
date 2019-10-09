import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:funlab/common/services/special/api.client.config.dart';

Task taskFromJson(String str) {
  final jsonData = json.decode(str);
  return Task.fromJson(jsonData);
}

String taskToJson(Task data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

List<Task> allTasksFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Task>.from(jsonData.map((x) => Task.fromJson(x)));
}

String allTasksToJson(List<Task> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Task {
  int id;
  String name;
  int difficulty;
  int sessionID;

  Task({this.id, this.name, this.difficulty, this.sessionID});

  factory Task.fromJson(Map<String, dynamic> json) => new Task(
        id: json["id"],
        name: json["name"],
        difficulty: json["difficulty"],
        sessionID: json["session_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "difficulty": difficulty,
        "session_id": sessionID,
      };

  static List<Task> tasksResponseFromJson(
      http.Response response) {
    if (response.statusCode == Config.getSuccess) {
      List<Task> tasks = allTasksFromJson(response.body);
      if (tasks.length == 0) {
        return List<Task>();
      } else {
        return tasks;
      }
    } else {
      return List<Task>();
    }
  }
}
