// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:finalproject_t_shop/models/config.dart';
import 'package:finalproject_t_shop/models/users.dart';
import 'package:finalproject_t_shop/screens/home.dart';
import 'package:finalproject_t_shop/screens/login.dart';
import 'package:finalproject_t_shop/user/userinfo.dart';
import 'package:finalproject_t_shop/user/userorder.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    String accountFN = "N/A";
    String accountLN = "N/A";
    String accountUrl =
        "https://www.shareicon.net/data/512x512/2016/05/24/770117_people_512x512.png";

    Users user = Configure.login;
    print(user.toJson().toString());
    if (user.id != null) {
      accountFN = user.firstname!;
      accountLN = user.lastname!;
    }
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              accountFN,
              style: TextStyle(fontSize: 15),
            ),
            accountEmail: Text(accountLN, style: TextStyle(fontSize: 15)),
            currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(accountUrl),
                backgroundColor: Color(0xFF2E2E2E),
                radius: 30.0),
            decoration: BoxDecoration(
                color: Color(0xFF2E2E2E) // กำหนดสีพื้นหลังของ Container
                ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pushNamed(context, Home.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserInfo(),
                      settings: RouteSettings(arguments: user)));
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text("My Order"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserOrder(),
                      settings: RouteSettings(arguments: user)));
            },
          ),
          Spacer(), // เพิ่ม Spacer เพื่อช่วยให้ปุ่ม Logout อยู่ด้านล่างสุด
          ListTile(
            // กำหนดพื้นหลังเป็นสีแดง
            tileColor: Colors.red,
            leading: Icon(Icons.logout,
                color: Colors.white), // ใส่ไอคอนและสีของไอคอนเป็นขาว
            title: Text("Logout",
                style: TextStyle(
                    color: Colors.white)), // ใส่ข้อความและสีข้อความเป็นขาว
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                  settings: RouteSettings(arguments: user),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
