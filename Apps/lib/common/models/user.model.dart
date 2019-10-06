import 'dart:convert';

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

String userToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}


List<User> allUsersFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<User>.from(jsonData.map((x) => User.fromJson(x)));
}

String allUsersToJson(List<User> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class User {
  String username;
  String name;
  String email;
  String id;

  User({
    this.username,
    this.name,
    this.email,
    this.id
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
    username: json["username"],
    name: json["name"],
    email: json["email"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "name": name,
    "email": email,
    "id": id,
  };
}