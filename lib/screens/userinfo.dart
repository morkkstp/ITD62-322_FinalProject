// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:finalproject_t_shop/models/users.dart';
import 'package:finalproject_t_shop/screens/sidemenu.dart';
import 'package:finalproject_t_shop/screens/useredit.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  static const routeName = "/profile";

  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as Users;

    return Scaffold(
        appBar: AppBar(
            title: const Text("User Info"), backgroundColor: Color(0xFF2E2E2E)),
        drawer: SideMenu(),
        body: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                    title: Center(
                        child:
                            Text("Profile", style: TextStyle(fontSize: 30)))),
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
                SizedBox(height: 20.0),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserEdit(),
                                settings: RouteSettings(arguments: user)));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          padding: const EdgeInsets.all(20.0)),
                      child: Text("Edit Profile"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          padding: const EdgeInsets.all(20.0)),
                      child: Text("Edit Profile"),
                    )
                  ],
                )
              ],
            )));
  }
}
