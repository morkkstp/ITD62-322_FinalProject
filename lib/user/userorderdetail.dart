// ignore_for_file: prefer_const_constructors

import 'package:finalproject_t_shop/models/users.dart';
import 'package:flutter/material.dart';

class UserOrderDetail extends StatelessWidget {
  const UserOrderDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var user = ModalRoute.of(context)!.settings.arguments as Users;
    var imgorder = user.myorder![0].img;
    imgorder ??=
        'https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-20.jpg';
    return Scaffold(
        appBar: AppBar(
            title: Text("T-Shirt Detail"), backgroundColor: Color(0xFF2E2E2E)),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Card(
              child: ListView(
                children: [
                  AspectRatio(
                      aspectRatio: 16 / 9, child: Image.network(imgorder)),
                  ListTile(
                      title:
                          Text("T-Shirt Name", style: TextStyle(fontSize: 15)),
                      subtitle: Text("${user.myorder?[0].name}")),
                  ListTile(
                      title: Text("T-Shirt Price"),
                      subtitle: Text("${user.myorder?[0].price} THB")),
                  ListTile(
                      title: Text("T-Shirt Size"),
                      subtitle: Text("${user.myorder?[0].size}")),
                  ListTile(
                      title: Text("T-Shirt Count"),
                      subtitle: Text("${user.myorder?[0].count}")),
                  ListTile(
                      title: Text("Total Price"),
                      subtitle: Text("${user.myorder?[0].totalprice} THB")),
                  ListTile(
                      title: Text("Firstname"),
                      subtitle: Text("${user.myorder?[0].firstname}")),
                  ListTile(
                      title: Text("Lastname"),
                      subtitle: Text("${user.myorder?[0].lastname}")),
                  ListTile(
                      title: Text("Phone"),
                      subtitle: Text("${user.myorder?[0].phone}")),
                  ListTile(
                      title: Text("Address"),
                      subtitle: Text("${user.myorder?[0].address}")),
                ],
              ),
            ),
          ),
        ));
  }
}
