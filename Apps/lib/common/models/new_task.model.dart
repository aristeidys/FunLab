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
  String name;

  NewTask({
    this.name
  });

  factory NewTask.fromJson(Map<String, dynamic> json) => new NewTask(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}