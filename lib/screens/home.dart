// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, prefer_if_null_operators, library_private_types_in_public_api

import 'package:finalproject_t_shop/models/config.dart';
import 'package:finalproject_t_shop/models/tshirt.dart';
import 'package:finalproject_t_shop/models/users.dart';
import 'package:finalproject_t_shop/screens/sidemenu.dart';
import 'package:finalproject_t_shop/tshirt/tshirtinfo.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  static const routeName = "/";
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget mainBody = CircularProgressIndicator();
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
      itemCount: (_tshirtList.length / 2).ceil() + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "T-Shirt Collection",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Divider(height: 2.0, color: Colors.black),
              ),
            ],
          );
        } else {
          final int rowIndex = index - 1;
          final int startIndex = rowIndex * 2;
          final int endIndex = startIndex + 2;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children:
                    _tshirtList.sublist(startIndex, endIndex).map((tshirt) {
                  return Expanded(
                    child: Card(
                      margin: EdgeInsets.all(10.0),
                      elevation: 2.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.network(
                                      "${tshirt.img}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("${tshirt.name}"),
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            "Rating: ${tshirt.rating!.rate} ⭐️",
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.grey[700])),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${tshirt.price} THB",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 0, 0),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TshirtInfo(),
                                        settings:
                                            RouteSettings(arguments: tshirt),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                  ),
                                  child: Text(
                                    "Buy",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Color(0xFF2E2E2E),
      ),
      drawer: SideMenu(),
      body: mainBody,
    );
  }
}
