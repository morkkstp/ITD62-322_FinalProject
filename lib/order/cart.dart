// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print, camel_case_types

import 'dart:convert';

import 'package:finalproject_t_shop/models/config.dart';
import 'package:finalproject_t_shop/models/order.dart';
import 'package:finalproject_t_shop/models/users.dart';
import 'package:finalproject_t_shop/order/preorder.dart';
import 'package:finalproject_t_shop/screens/sidemenu.dart';
import 'package:finalproject_t_shop/tshirt/tshirtedit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class addToCart extends StatefulWidget {
  static const routeName = "/addtocart";

  const addToCart({super.key});

  @override
  State<addToCart> createState() => _addToCartState();
}

class _addToCartState extends State<addToCart> {
  Users user = Configure.login;
  late Order order;
  Widget mainBody = Container();
  List<Order> orderList = [];

  @override
  void initState() {
    super.initState();
    Users user = Configure.login;
    if (user.id != null) {
      getOrder();
    }
  }

  Future<void> getOrder() async {
    var url = Uri.http(Configure.server, "order");
    var resp = await http.get(url);
    setState(() {
      orderList = orderFromJson(resp.body);
      mainBody = showUsers();
    });
    return;
  }

  Future<void> removeOrder(order) async {
    var url = Uri.http(Configure.server, "order/${order.id}");
    var resp = await http.delete(url);
    print(resp.body);
    return;
  }

  Future<void> updateOrder(Map<String, dynamic> order) async {
    var url = Uri.http(
        Configure.server, "order/${order['id']}"); // อัปเดตตาม ID ของ order
    var resp = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(order), // ใช้ order ในการอัปเดต
    );
    var rs = orderFromJson("[${resp.body}]");
    print(rs.toString());
    print("Updated Status.");
  }

  Widget showUsers() {
    if (orderList.isEmpty) {
      return Center(
        child: Text(
          "No Order",
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          Order order = orderList[index];
          var imgUrl = order.img ??
              'https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-20.jpg';

          if (order.status != "success") {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text("${order.name}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text(
                              "Price: ${order.price != null ? '${order.price} THB' : 'N/A'}"),
                          SizedBox(height: 5),
                          Text("Size: ${order.size ?? 'N/A'}"),
                          SizedBox(height: 5),
                          Text("Count: ${order.count ?? 'N/A'}"),
                          SizedBox(height: 5),
                          Text(
                              "Total Price: ${order.totalprice != null ? '${order.totalprice} THB' : 'N/A'}"),
                          SizedBox(height: 5),
                        ],
                      ),
                      leading: AspectRatio(
                          aspectRatio: 1, child: Image.network(imgUrl)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              String result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PreOrder(),
                                  settings: RouteSettings(arguments: order),
                                ),
                              );
                              if (result == "refresh") {
                                getOrder();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12.0),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: Colors.green,
                                  width: 1.0,
                                ),
                              ),
                              child: Text(
                                'Accept',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () async {
                              String result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TshirtEdit(),
                                  settings: RouteSettings(arguments: order),
                                ),
                              );
                              if (result == "refresh") {
                                getOrder();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12.0),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 1.0,
                                ),
                              ),
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () async {
                              // เรียกฟังก์ชัน removeOrder เมื่อปุ่ม Delete ถูกกด
                              await removeOrder(order);
                              // เรียกฟังก์ชัน getOrder เพื่อรีโหลดข้อมูลใหม่
                              getOrder();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12.0),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: Colors.red,
                                  width: 1.0,
                                ),
                              ),
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return null;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: Color(0xFF2E2E2E),
      ),
      drawer: SideMenu(),
      body: mainBody,
    );
  }
}
