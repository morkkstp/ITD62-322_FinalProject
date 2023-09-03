// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, unused_local_variable

import 'package:finalproject_t_shop/models/config.dart';
import 'package:finalproject_t_shop/models/tshirt.dart';
import 'package:flutter/material.dart';

class TshirtInfo extends StatefulWidget {
  static const routeName = "/tshirt";

  const TshirtInfo({super.key});

  @override
  State<TshirtInfo> createState() => _TshirtInfoState();
}

class _TshirtInfoState extends State<TshirtInfo> {
  // Tshirt tshirt = Tshirt();
  late Tshirt tshirt;

  // Widget chooseSize() {
  //   var initGen = "S";
  //   try {
  //     if (tshirt.size!.isEmpty) {
  //       initGen = tshirt.size!;
  //     }
  //   } catch (e) {
  //     initGen = "None";
  //   }

  //   return DropdownButtonFormField(
  //       decoration: InputDecoration(labelText: "Size"),
  //       value: 'S',
  //       items: Configure.size.map((String val) {
  //         return DropdownMenuItem(
  //           value: val,
  //           child: Text(val),
  //         );
  //       }).toList(),
  //       onChanged: (value) {
  //         tshirt.size = value;
  //       },
  //       onSaved: (newValue) => tshirt.size);
  // }

  @override
  Widget build(BuildContext context) {
    var tshirt = ModalRoute.of(context)!.settings.arguments as Tshirt;
    var imgUrl = tshirt.img;
    imgUrl ??=
        'https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-20.jpg';

    try {
      tshirt = ModalRoute.of(context)!.settings.arguments as Tshirt;
      print(tshirt.name);
    } catch (e) {
      tshirt = Tshirt();
    }
    return Scaffold(
      appBar: AppBar(
          title: Text("${tshirt.name}"), backgroundColor: Color(0xFF2E2E2E)),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Card(
          child: ListView(
            children: [
              AspectRatio(aspectRatio: 16 / 9, child: Image.network(imgUrl)),
              ListTile(
                  title: Text("T-Shirt Name"),
                  subtitle: Text("${tshirt.name}")),
              ListTile(
                  title: Text("T-Shirt Description"),
                  subtitle: Text("${tshirt.description}")),
              ListTile(
                  title: Text("T-Shirt Price"),
                  subtitle: Text("${tshirt.price} THB")),
              ListTile(title: Text("T-Shirt Size")),
              // chooseSize(),
            ],
          ),
        ),
      ),
    );
  }
}
