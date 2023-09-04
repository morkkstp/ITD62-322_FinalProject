// ignore_for_file: prefer_const_constructors

import 'package:finalproject_t_shop/models/users.dart';
import 'package:finalproject_t_shop/screens/sidemenu.dart';
import 'package:flutter/material.dart';

class UserOrder extends StatelessWidget {
  static const routeName = "/order";

  const UserOrder({super.key});

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as Users.Myorder;

// ตัวอย่างการเข้าถึงข้อมูลใน array
    var firstOrder = user.orders[0]; // เข้าถึงอันแรกใน array
    var secondOrder = user.orders[1]; // เข้าถึงอันที่สองใน array

    return Scaffold(
        appBar: AppBar(
            title: const Text("My Order"), backgroundColor: Color(0xFF2E2E2E)),
        drawer: SideMenu(),
        body: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                    title: Center(
                        child: Text("Order of ${user.firstname}",
                            style: TextStyle(fontSize: 30)))),
                ListTile(
                    title: Text("Username"),
                    subtitle: Text("${user.username}")),
                ListTile(
                    title: Text("Password"),
                    subtitle: Text("${user.password}")),
                ListTile(
                    title: Text("Firstname"),
                    subtitle: Text("${user.firstname}")),
                ListTile(
                    title: Text("Lastname"),
                    subtitle: Text("${user.lastname}")),
                ListTile(title: Text("Phone"), subtitle: Text("${user.phone}")),
                ListTile(
                    title: Text("Address"), subtitle: Text("${user.address}")),
              ],
            )));
  }
}
