// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:finalproject_t_shop/models/tshirt.dart';
import 'package:flutter/material.dart';

class TshirtInfo extends StatelessWidget {
  static const routeName = "/tshirt";

  const TshirtInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var tshirt = ModalRoute.of(context)!.settings.arguments as Tshirt;
    var imgts = tshirt.img;
    imgts ??=
        'https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-20.jpg';

    return Scaffold(
      appBar: AppBar(
          title: Text("${tshirt.name}"), backgroundColor: Color(0xFF2E2E2E)),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Card(
          child: ListView(
            children: [
              AspectRatio(aspectRatio: 16 / 9, child: Image.network(imgts)),
              ListTile(
                  title: Text("T-Shirt Name"),
                  subtitle: Text("${tshirt.name}")),
              ListTile(
                  title: Text("T-Shirt Description"),
                  subtitle: Text("${tshirt.description}")),
              ListTile(
                  title: Text("T-Shirt Price"),
                  subtitle: Text("${tshirt.price}")),
            ],
          ),
        ),
      ),
    );
  }
}
