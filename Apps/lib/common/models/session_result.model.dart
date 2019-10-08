import 'dart:convert';

SessionResult sessionResultFromJson(String str) {
  final jsonData = json.decode(str);
  return SessionResult.fromJson(jsonData);
}

String sessionResultToJson(SessionResult data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}


List<SessionResult> allSessionResultsFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<SessionResult>.from(jsonData.map((x) => SessionResult.fromJson(x)));
}

String allSessionResultsToJson(List<SessionResult> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class SessionResult {
  String id;
  String studentID;
  String sessionID;
  
  SessionResult({
    this.id,
    this.studentID,
    this.sessionID
  });

  factory SessionResult.fromJson(Map<String, dynamic> json) => new SessionResult(
    id: json["id"],
    studentID: json["student_id"],
    sessionID: json["session_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "student_id": studentID,
    "session_id": sessionID,
  };
}