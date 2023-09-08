// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  int? id;
  String? username;
  String? password;
  String? firstname;
  String? lastname;
  String? phone;
  String? address;

  Users({
    this.id,
    this.username,
    this.password,
    this.firstname,
    this.lastname,
    this.phone,
    this.address,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        phone: json["phone"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "firstname": firstname,
        "lastname": lastname,
        "phone": phone,
        "address": address,
      };
}
