import 'dart:convert';

Classroom postFromJson(String str) {
  final jsonData = json.decode(str);
  return Classroom.fromJson(jsonData);
}

String postToJson(Classroom data) {
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
  String name;

  Classroom({
    this.name
  });

  factory Classroom.fromJson(Map<String, dynamic> json) => new Classroom(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}