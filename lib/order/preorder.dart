// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

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

  Future<void> addOrder(BuildContext context, user) async {
    var url = Uri.http(Configure.server, '/users/${user.id}}');
    var resp = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(order.toJson()),
    );
    var rs = orderFromJson("[${resp.body}]");
    if (rs.length == 1) {
      Navigator.pushNamed(context, '/order');
    }
    return;
  }

  Widget addOrderButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          user.myorder?[0].name = order.name;
          user.myorder?[0].price = order.price;
          user.myorder?[0].size = order.size;
          user.myorder?[0].img = order.img;
          user.myorder?[0].count = order.count;
          user.myorder?[0].totalprice = order.totalprice;
          addOrder(context, order);
        }
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
          title: const Text("Tshirt Cart Edit"),
          backgroundColor: const Color(0xFF2E2E2E)),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Form(
          key: _formkey,
          child: ListView(
            // Wrap your Column with a ListView
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(imgUrl),
              ),
              ListTile(
                title:
                    const Text("T-Shirt Name", style: TextStyle(fontSize: 15)),
                subtitle: Text("${order.name}"),
              ),
              ListTile(
                title: const Text("T-Shirt Price"),
                subtitle: Text("${order.price} THB"),
              ),
              ListTile(
                title: const Text("T-Shirt Size"),
                subtitle: Text("${order.size}"),
              ),
              ListTile(
                title: const Text("T-Shirt Count"),
                subtitle: Text("${order.count}"),
              ),
              ListTile(
                title: const Text("T-Shirt Total Price"),
                subtitle: Text("${order.size}"),
              ),
              ListTile(
                title: const Text("Order Address"),
              ),
              ListTile(
                title: const Text("Firstname"),
                subtitle: Text("${user.firstname}"),
              ),
              ListTile(
                title: const Text("Lastname"),
                subtitle: Text("${user.lastname}"),
              ),
              ListTile(
                title: const Text("Phone Number"),
                subtitle: Text("${user.phone}"),
              ),
              ListTile(
                title: const Text("Address"),
                subtitle: Text("${user.address}"),
              ),
              addOrderButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
