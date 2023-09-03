// ignore_for_file: prefer_const_constructors, unused_field, sort_child_properties_last, avoid_print

import 'package:finalproject_t_shop/models/config.dart';
import 'package:finalproject_t_shop/models/tshirt.dart';
import 'package:finalproject_t_shop/models/users.dart';
import 'package:finalproject_t_shop/screens/sidemenu.dart';
import 'package:finalproject_t_shop/screens/tshirtinfo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  static const routeName = "/";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget mainBody = Container();
  List<Tshirt> _tshirtList = [];

  @override
  void initState() {
    super.initState();
    Users user = Configure.login;
    if (user.id != null) {
      getTshirt();
    }
  }

  Future<void> getTshirt() async {
    var url = Uri.http(Configure.server, "tshirt");
    var resp = await http.get(url);
    setState(() {
      _tshirtList = tshirtFromJson(resp.body);
      mainBody = showTshirt();
    });
    return;
  }

  Widget showTshirt() {
    return ListView.builder(
        itemCount: _tshirtList.length,
        itemBuilder: (context, index) {
          Tshirt tshirt = _tshirtList[index];
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            child: Card(
                child: ListTile(
                    title: Text("${tshirt.name}"),
                    subtitle: Text("${tshirt.price} THB"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TshirtInfo(),
                              settings: RouteSettings(arguments: tshirt)));
                    } // to show info
                    )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("T-Shirt"),
        backgroundColor: Color(0xFF2E2E2E),
      ),
      drawer: SideMenu(),
      body: mainBody,
    );
  }
}
