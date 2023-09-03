// To parse this JSON data, do
//
//     final tshirt = tshirtFromJson(jsonString);

import 'dart:convert';

List<Tshirt> tshirtFromJson(String str) =>
    List<Tshirt>.from(json.decode(str).map((x) => Tshirt.fromJson(x)));

String tshirtToJson(List<Tshirt> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tshirt {
  int? id;
  String? name;
  String? description;
  String? img;
  int? price;
  List<String>? size;

  Tshirt({
    this.id,
    this.name,
    this.description,
    this.img,
    this.price,
    this.size,
  });

  factory Tshirt.fromJson(Map<String, dynamic> json) => Tshirt(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        img: json["img"],
        price: json["price"],
        size: json["size"] == null
            ? []
            : List<String>.from(json["size"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "img": img,
        "price": price,
        "size": size == null ? [] : List<dynamic>.from(size!.map((x) => x)),
      };
}
