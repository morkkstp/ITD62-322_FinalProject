// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:finalproject_t_shop/models/users.dart';
import 'package:finalproject_t_shop/screens/sidemenu.dart';
import 'package:finalproject_t_shop/user/useredit.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  static const routeName = "/profile";

  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as Users;

    return Scaffold(
        appBar: AppBar(
            title: const Text("Profile"), backgroundColor: Color(0xFF2E2E2E)),
        drawer: SideMenu(),
        body: Card(
            margin: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListTile(
                  title: Center(
                    child: Text("Hello ${user.firstname}",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                ),
                AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                        "https://www.shareicon.net/data/512x512/2016/05/24/770117_people_512x512.png")),
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Divider(height: 2.0, color: Colors.black),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text("Username"),
                        subtitle: Text("${user.username}"),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text("Password"),
                        subtitle: Text("${user.password}"),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text("Firstname"),
                        subtitle: Text("${user.firstname}"),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text("Lastname"),
                        subtitle: Text("${user.lastname}"),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text("Phone"),
                        subtitle: Text("${user.phone}"),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text("Address"),
                        subtitle: Text("${user.address}"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserEdit(),
                            settings: RouteSettings(arguments: user),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: EdgeInsets.all(12.0),
                      ),
                      child: Text("Edit Profile"),
                    ),
                  ],
                )
              ],
            )));
  }
}
