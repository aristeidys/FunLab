import 'dart:convert';

Enrollment enrollmentFromJson(String str) {
  final jsonData = json.decode(str);
  return Enrollment.fromJson(jsonData);
}

String enrollmentToJson(Enrollment data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

List<Enrollment> allEnrollmentsFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Enrollment>.from(jsonData.map((x) => Enrollment.fromJson(x)));
}

String allEnrollmentsToJson(List<Enrollment> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Enrollment {
  int id;
  int studentID;
  int classroomID;
  bool isActive;
  Enrollment({this.id, this.studentID, this.classroomID, this.isActive});

  factory Enrollment.fromJson(Map<String, dynamic> json) => new Enrollment(
        id: json["id"],
        studentID: json["student_id"],
        classroomID: json["classroom_id"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentID,
        "classroom_id": classroomID,
        "isActive": isActive,
      };
}
