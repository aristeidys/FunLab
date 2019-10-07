import 'dart:convert';

Classroom classroomFromJson(String str) {
  final jsonData = json.decode(str);
  return Classroom.fromJson(jsonData);
}

String classroomToJson(Classroom data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}


List<Classroom> allClassroomsFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Classroom>.from(jsonData.map((x) => Classroom.fromJson(x)));
}

String allClassroomsToJson(List<Classroom> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Classroom {
  int id;
  String name;
  int instructorID;

  Classroom({
    this.id,
    this.name,
    this.instructorID
  });

  factory Classroom.fromJson(Map<String, dynamic> json) => new Classroom(
    id: json["id"],
    name: json["name"],
    instructorID: json["instructor_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "instructor_id": instructorID,
  };
}