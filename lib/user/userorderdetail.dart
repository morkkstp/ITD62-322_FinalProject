// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:finalproject_t_shop/models/config.dart';
import 'package:finalproject_t_shop/models/myorder.dart';
import 'package:flutter/material.dart';

class UserOrderDetail extends StatefulWidget {
  static const routeName = "/orderdetail";

  const UserOrderDetail({Key? key}) : super(key: key);

  @override
  State<UserOrderDetail> createState() => _UserOrderDetailState();
}

class _UserOrderDetailState extends State<UserOrderDetail> {
  final _formkey = GlobalKey<FormState>();
  late Myorder myorder;

  @override
  void initState() {
    super.initState();
    myorder = Myorder();
  }

  @override
  Widget build(BuildContext context) {
    myorder = ModalRoute.of(context)!.settings.arguments as Myorder;

    final imgOrder = myorder.img ??
        'https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-20.jpg';

    return Scaffold(
      appBar: AppBar(
        title: Text("T-Shirt Detail"),
        backgroundColor: Color(0xFF2E2E2E),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: ListView(
          key: _formkey,
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
                child: Image.network(imgOrder),
              ),
            ),
            ListTile(
              title: const Text("T-Shirt Name", style: TextStyle(fontSize: 15)),
              subtitle: Text("${myorder.name}"),
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text("T-Shirt Price"),
                    subtitle: Text("${myorder.price} THB"),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text("T-Shirt Size"),
                    subtitle: Text("${myorder.size}"),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text("T-Shirt Count"),
                    subtitle: Text("${myorder.count} item"),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text("T-Shirt Total Price"),
                    subtitle: Text("${myorder.totalprice} THB"),
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
                    subtitle: Text("${Configure.login.firstname}"),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text("Lastname"),
                    subtitle: Text("${Configure.login.lastname}"),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text("Phone Number"),
                    subtitle: Text("${Configure.login.phone}"),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text("Address"),
                    subtitle: Text("${Configure.login.address}"),
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
