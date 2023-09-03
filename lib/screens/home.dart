// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, prefer_if_null_operators, library_private_types_in_public_api

import 'package:finalproject_t_shop/models/config.dart';
import 'package:finalproject_t_shop/models/tshirt.dart';
import 'package:finalproject_t_shop/models/users.dart';
import 'package:finalproject_t_shop/screens/sidemenu.dart';
import 'package:finalproject_t_shop/screens/tshirtinfo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  static const routeName = "/";
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Widget mainBody;
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
      itemCount: (_tshirtList.length / 2).ceil(),
      itemBuilder: (BuildContext context, int rowIndex) {
        final int startIndex = rowIndex * 2;
        final int endIndex = startIndex + 2;

        return Row(
          children: _tshirtList.sublist(startIndex, endIndex).map((tshirt) {
            return Expanded(
              child: Card(
                margin: EdgeInsets.all(8.0),
                elevation: 2.0,
                child: Column(
                  children: [
                    ListTile(
                      title: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: Image.network(
                              "${tshirt.img}",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text("${tshirt.name}"),
                          SizedBox(height: 10.0),
                          Text("${tshirt.price} THB"),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TshirtInfo(),
                            settings: RouteSettings(arguments: tshirt),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("T-Shirt"),
        backgroundColor: Color(0xFF2E2E2E),
      ),
      drawer: SideMenu(),
      body: mainBody != null ? mainBody : CircularProgressIndicator(),
    );
  }
}
