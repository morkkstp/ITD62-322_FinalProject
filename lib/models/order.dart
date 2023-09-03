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
  String? size;
  int? count;
  int? totalprice;
  String? firstname;
  String? lastname;
  String? phone;
  String? address;

  Order({
    this.id,
    this.name,
    this.size,
    this.count,
    this.totalprice,
    this.firstname,
    this.lastname,
    this.phone,
    this.address,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        name: json["name"],
        size: json["size"],
        count: json["count"],
        totalprice: json["totalprice"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        phone: json["phone"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "size": size,
        "count": count,
        "totalprice": totalprice,
        "firstname": firstname,
        "lastname": lastname,
        "phone": phone,
        "address": address,
      };
}
