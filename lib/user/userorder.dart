// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:finalproject_t_shop/models/users.dart';
import 'package:finalproject_t_shop/screens/sidemenu.dart';
import 'package:flutter/material.dart';

class UserOrder extends StatelessWidget {
  static const routeName = "/order";

  const UserOrder({super.key});

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as Users;
    Myorder myorder = Myorder();

    return Scaffold(
        appBar: AppBar(
            title: const Text("My Order"), backgroundColor: Color(0xFF2E2E2E)),
        drawer: SideMenu(),
        body: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: user.myorder!.length,
          itemBuilder: (context, index) {
            var imgorder = user.myorder![index].img;
            imgorder ??=
                'https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-20.jpg';
            return Card(
              child: ListTile(
                title: Text("Product Name: ${user.myorder?[0].name ?? 'N/A'}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Price: ${user.myorder?[0].price ?? 'N/A'}"),
                    Text("Size: ${user.myorder?[0].size ?? 'N/A'}"),
                    Text("Count: ${user.myorder?[0].count ?? 'N/A'}"),
                    Text(
                        "Total Price: ${user.myorder?[0].totalprice ?? 'N/A'}"),
                    Text("Firstname: ${user.myorder?[0].firstname ?? 'N/A'}"),
                    Text("Lastname: ${user.myorder?[0].lastname ?? 'N/A'}"),
                    Text("Phone: ${user.myorder?[0].phone ?? 'N/A'}"),
                    Text("Address: ${user.myorder?[0].address ?? 'N/A'}"),
                  ],
                ),
                leading: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(imgorder),
                ),
              ),
            );
          },
        ));
  }
}
