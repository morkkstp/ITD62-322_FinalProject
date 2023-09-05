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
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(imgOrder),
            ),
            ListTile(
              title: Text("T-Shirt Name", style: TextStyle(fontSize: 15)),
              subtitle: Text("${myOrder.name}"),
            ),
            ListTile(
              title: Text("T-Shirt Price"),
              subtitle: Text("${myOrder.price} THB"),
            ),
            ListTile(
              title: Text("T-Shirt Size"),
              subtitle: Text("${myOrder.size}"),
            ),
            ListTile(
              title: Text("T-Shirt Count"),
              subtitle: Text("${myOrder.count}"),
            ),
            ListTile(
              title: Text("Total Price"),
              subtitle: Text("${myOrder.totalprice} THB"),
            ),
            ListTile(
              title: Text("Firstname"),
              subtitle: Text("${user.firstname}"),
            ),
            ListTile(
              title: Text("Lastname"),
              subtitle: Text("${user.lastname}"),
            ),
            ListTile(
              title: Text("Phone Number"),
              subtitle: Text("${user.phone}"),
            ),
            ListTile(
              title: Text("Address"),
              subtitle: Text("${user.address}"),
            ),
          ],
        ),
      ),
    );
  }
}
