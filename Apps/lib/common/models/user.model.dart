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
  String email;
  String name;
  String password;
  int id;

  User({
    this.email,
    this.name,
    this.password,
    this.id
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
    email: json["email"],
    name: json["name"],
    password: json["password"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "name": name,
    "password": password,
    "id": id,
  };
}