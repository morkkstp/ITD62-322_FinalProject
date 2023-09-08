// To parse this JSON data, do
//
//     final myorder = myorderFromJson(jsonString);

import 'dart:convert';

List<Myorder> myorderFromJson(String str) =>
    List<Myorder>.from(json.decode(str).map((x) => Myorder.fromJson(x)));

String myorderToJson(List<Myorder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Myorder {
  int? id;
  int? uid;
  String? name;
  int? price;
  String? size;
  String? img;
  int? count;
  int? totalprice;

  Myorder({
    this.id,
    this.uid,
    this.name,
    this.price,
    this.size,
    this.img,
    this.count,
    this.totalprice,
  });

  factory Myorder.fromJson(Map<String, dynamic> json) => Myorder(
        id: json["id"],
        uid: json["uid"],
        name: json["name"],
        price: json["price"],
        size: json["size"],
        img: json["img"],
        count: json["count"],
        totalprice: json["totalprice"],
      );

  get length => null;

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "name": name,
        "price": price,
        "size": size,
        "img": img,
        "count": count,
        "totalprice": totalprice,
      };
}
