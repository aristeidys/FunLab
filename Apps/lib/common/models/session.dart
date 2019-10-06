import 'dart:convert';

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
  String name;

  Session({
    this.name
  });

  factory Session.fromJson(Map<String, dynamic> json) => new Session(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}