// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, avoid_print, unused_local_variable

import 'dart:convert';

import 'package:finalproject_t_shop/models/config.dart';
import 'package:finalproject_t_shop/models/order.dart';
import 'package:finalproject_t_shop/models/users.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PreOrder extends StatefulWidget {
  static const routeName = "/preorder";

  const PreOrder({super.key});

  @override
  State<PreOrder> createState() => _PreOrderState();
}

class _PreOrderState extends State<PreOrder> {
  final _formkey = GlobalKey<FormState>();
  late Order order;
  Users user = Configure.login;

  @override
  void initState() {
    super.initState();
    order = Order();
  }

  Future<void> addOrder(Map<String, dynamic> order) async {
    var url = Uri.http(Configure.server, '/myorder');
    var resp = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(order),
    );
    var rs = orderFromJson("[${resp.body}]");
    if (rs.length == 1) {
      Navigator.pushNamed(context, '/order');
    }
    return;
  }

  Future<void> updateOrder(Map<String, dynamic> order) async {
    var url = Uri.http(
        Configure.server, "order/${order['id']}"); // อัปเดตตาม ID ของ order
    var resp = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(order), // ใช้ order ในการอัปเดต
    );
    var rs = orderFromJson("[${resp.body}]");
    print(rs.toString());
    print("Updated Status.");
  }

  Widget addOrderButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Map<String, dynamic> orderAdd = {
          "id": order.id,
          "uid": Configure.login.id,
          "name": order.name,
          "price": order.price,
          "size": order.size,
          "img": order.img,
          "count": order.count,
          "totalprice": order.totalprice,
          "status": "success"
        };
        Map<String, dynamic> orderUpdate = {
          "id": order.id,
          "name": order.name,
          "price": order.price,
          "size": order.size,
          "img": order.img,
          "count": order.count,
          "totalprice": order.totalprice,
          "status": "success"
        };
        addOrder(orderAdd);
        updateOrder(orderUpdate);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.all(10.0),
      ),
      child: Text("Order"),
    );
  }

  @override
  Widget build(BuildContext context) {
    order = ModalRoute.of(context)!.settings.arguments as Order;
    var imgUrl = order.img ??
        'https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-20.jpg';

    try {
      order = ModalRoute.of(context)!.settings.arguments as Order;
      print(order.name);
    } catch (e) {
      order = Order();
    }
    return Scaffold(
      appBar: AppBar(
          title: const Text("Tshirt Pre-Order Detail"),
          backgroundColor: const Color(0xFF2E2E2E)),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Form(
          key: _formkey,
          child: ListView(
            // Wrap your Column with a ListView
            children: [
              ListTile(
                title: const Text("T-Shirt Detail",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Divider(height: 2.0, color: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(imgUrl),
                ),
              ),
              ListTile(
                title:
                    const Text("T-Shirt Name", style: TextStyle(fontSize: 15)),
                subtitle: Text("${order.name}"),
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text("T-Shirt Price"),
                      subtitle: Text("${order.price} THB"),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text("T-Shirt Size"),
                      subtitle: Text("${order.size}"),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text("T-Shirt Count"),
                      subtitle: Text("${order.count} item"),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text("T-Shirt Total Price"),
                      subtitle: Text("${order.totalprice} THB"),
                    ),
                  )
                ],
              ),
              ListTile(
                title: const Text(
                  "Order Address",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Divider(height: 2.0, color: Colors.black),
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text("Firstname"),
                      subtitle: Text("${user.firstname}"),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text("Lastname"),
                      subtitle: Text("${user.lastname}"),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text("Phone Number"),
                      subtitle: Text("${user.phone}"),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text("Address"),
                      subtitle: Text("${user.address}"),
                    ),
                  )
                ],
              ),
              addOrderButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
