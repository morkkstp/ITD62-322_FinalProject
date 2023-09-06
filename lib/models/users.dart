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
  List<Myorder>? myorder;

  Users({
    this.id,
    this.username,
    this.password,
    this.firstname,
    this.lastname,
    this.phone,
    this.address,
    this.myorder,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        phone: json["phone"],
        address: json["address"],
        myorder: json["myorder"] == null
            ? []
            : List<Myorder>.from(
                json["myorder"].map((x) => Myorder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "firstname": firstname,
        "lastname": lastname,
        "phone": phone,
        "address": address,
        "myorder": myorder == null
            ? []
            : List<dynamic>.from(myorder!.map((x) => x.toJson())),
      };
}

class Myorder {
  int? id;
  String? name;
  int? price;
  String? size;
  String? img;
  int? count;
  int? totalprice;

  Myorder({
    this.id,
    this.name,
    this.price,
    this.size,
    this.img,
    this.count,
    this.totalprice,
  });

  factory Myorder.fromJson(Map<String, dynamic> json) => Myorder(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        size: json["size"],
        img: json["img"],
        count: json["count"],
        totalprice: json["totalprice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "size": size,
        "img": img,
        "count": count,
        "totalprice": totalprice,
      };
}
