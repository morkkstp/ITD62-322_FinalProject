// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:finalproject_t_shop/models/config.dart';
import 'package:flutter/material.dart';
import 'package:finalproject_t_shop/models/users.dart';

class UserOrderDetail extends StatelessWidget {
  final Myorder myOrder;
  Users user = Configure.login;

  UserOrderDetail({Key? key, required this.myOrder});

  @override
  Widget build(BuildContext context) {
    // ใช้ข้อมูลจาก myOrder ในการแสดงข้อมูลที่ถูกเลือก
    final imgOrder = myOrder.img ??
        'https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-20.jpg';

    return Scaffold(
      appBar: AppBar(
        title: Text("T-Shirt Detail"),
        backgroundColor: Color(0xFF2E2E2E),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: ListView(
          children: [
            ListTile(
              title: const Text("T-Shirt Detail",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Divider(height: 2.0, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                // child: Image.network(imgUrl),
              ),
            ),
            ListTile(
              title: const Text("T-Shirt Name", style: TextStyle(fontSize: 15)),
              // subtitle: Text("${order.name}"),
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text("T-Shirt Price"),
                    // subtitle: Text("${order.price} THB"),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text("T-Shirt Size"),
                    // subtitle: Text("${order.size}"),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text("T-Shirt Count"),
                    // subtitle: Text("${order.count} item"),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text("T-Shirt Total Price"),
                    // subtitle: Text("${order.totalprice} THB"),
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
          ],
        ),
      ),
    );
  }
}
