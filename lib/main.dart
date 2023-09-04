// ignore_for_file: prefer_const_constructors

import 'package:finalproject_t_shop/tshirt/tshirtinfo.dart';
import 'package:finalproject_t_shop/user/userinfo.dart';
import 'package:finalproject_t_shop/user/userorder.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'T_Shop',
      initialRoute: '/login',
      routes: {
        '/': (context) => const Home(),
        '/login': (context) => const Login(),
        '/profile': (context) => const UserInfo(),
        '/tshirt': (context) => const TshirtInfo(),
        '/order': (context) => const UserOrder()
      },
    );
  }
}
