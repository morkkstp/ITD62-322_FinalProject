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
  Rating? rating;

  Tshirt({
    this.id,
    this.name,
    this.description,
    this.img,
    this.price,
    this.rating,
  });

  factory Tshirt.fromJson(Map<String, dynamic> json) => Tshirt(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        img: json["img"],
        price: json["price"],
        rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "img": img,
        "price": price,
        "rating": rating?.toJson(),
      };
}

class Rating {
  int? count;
  double? rate;

  Rating({
    this.count,
    this.rate,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        count: json["count"],
        rate: json["rate"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "rate": rate,
      };
}
