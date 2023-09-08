// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

List<Order> orderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  int? id;
  String? name;
  int? price;
  String? size;
  String? img;
  int? count;
  int? totalprice;
  String? status;

  Order({
    this.id,
    this.name,
    this.price,
    this.size,
    this.img,
    this.count,
    this.totalprice,
    this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        size: json["size"],
        img: json["img"],
        count: json["count"],
        totalprice: json["totalprice"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "size": size,
        "img": img,
        "count": count,
        "totalprice": totalprice,
        "status": status,
      };
}
