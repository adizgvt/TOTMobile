// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String token;
  String name;
  String email;

  User({
    required this.token,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    token: json["token"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "name": name,
    "email": email,
  };
}
