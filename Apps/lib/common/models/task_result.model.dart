import 'dart:convert';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:funlab/common/services/special/response.dart';
import 'package:http/http.dart' as http;

TaskResult taskResultFromJson(String str) {
  final jsonData = json.decode(str);
  return TaskResult.fromJson(jsonData);
}

String taskResultToJson(TaskResult data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

List<TaskResult> allTaskResultsFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<TaskResult>.from(jsonData.map((x) => TaskResult.fromJson(x)));
}

String allTaskResultsToJson(List<TaskResult> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class TaskResult {
  int id;
  String taskName;
  int studentID;
  int taskID;
  bool completed;
  TaskResult({this.id, this.taskName, this.studentID, this.taskID, this.completed});

  static Response<List<TaskResult>> taskResultsFromJson(
      http.Response response) {
    if (response.statusCode == Config.getSuccess) {
      List<TaskResult> sessions = allTaskResultsFromJson(response.body);
      if (sessions.length == 0) {
        return Response(null, 'No Task Results found');
      } else {
        return Response(sessions, null);
      }
    } else {
      return Response(null, response.body);
    }
  }

  factory TaskResult.fromJson(Map<String, dynamic> json) => new TaskResult(
        id: json["id"],
        studentID: json["student_id"],
        taskName: json["task_name"],
        taskID: json["task_id"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentID,
        "task_name": taskName,
        "task_id": taskID,
        "completed": completed,
      };
}
