import 'dart:convert';

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
  int studentID;
  int taskID;
  bool completed;
  TaskResult({this.id, this.studentID, this.taskID, this.completed});

  factory TaskResult.fromJson(Map<String, dynamic> json) => new TaskResult(
        id: json["id"],
        studentID: json["student_id"],
        taskID: json["task_id"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentID,
        "task_id": taskID,
        "completed": completed,
      };
}
