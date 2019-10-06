import 'dart:convert';

NewTask taskFromJson(String str) {
  final jsonData = json.decode(str);
  return NewTask.fromJson(jsonData);
}

String taskToJson(NewTask data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}


List<NewTask> allTasksFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<NewTask>.from(jsonData.map((x) => NewTask.fromJson(x)));
}

String allTasksToJson(List<NewTask> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class NewTask {
  String id;
  String name;
  String sessionID;
  
  NewTask({
    this.id,
    this.name,
    this.sessionID
  });

  factory NewTask.fromJson(Map<String, dynamic> json) => new NewTask(
    id: json["id"],
    name: json["name"],
    sessionID: json["session_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "session_id": sessionID,
  };
}