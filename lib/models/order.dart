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
  int? uid;
  int? tid;
  String? name;
  int? price;
  String? size;
  String? img;
  int? count;
  int? totalprice;
  String? firstname;
  String? lastname;
  String? phone;
  String? address;

  Order({
    this.id,
    this.uid,
    this.tid,
    this.name,
    this.price,
    this.size,
    this.img,
    this.count,
    this.totalprice,
    this.firstname,
    this.lastname,
    this.phone,
    this.address,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        uid: json["uid"],
        tid: json["tid"],
        name: json["name"],
        price: json["price"],
        size: json["size"],
        img: json["img"],
        count: json["count"],
        totalprice: json["totalprice"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        phone: json["phone"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "tid": tid,
        "name": name,
        "price": price,
        "size": size,
        "img": img,
        "count": count,
        "totalprice": totalprice,
        "firstname": firstname,
        "lastname": lastname,
        "phone": phone,
        "address": address,
      };
}
