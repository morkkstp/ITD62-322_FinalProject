// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, sort_child_properties_last

import 'package:finalproject_t_shop/models/config.dart';
import 'package:finalproject_t_shop/models/order.dart';
import 'package:finalproject_t_shop/models/users.dart';
import 'package:finalproject_t_shop/screens/sidemenu.dart';
import 'package:finalproject_t_shop/tshirt/tshirtinfo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class addToCart extends StatefulWidget {
  static const routeName = "/addtocart";

  const addToCart({super.key});

  @override
  State<addToCart> createState() => _addToCartState();
}

class _addToCartState extends State<addToCart> {
  Widget mainBody = Container();
  List<Order> _orderList = [];

  @override
  void initState() {
    super.initState();
    Users user = Configure.login;
    if (user.id != null) {
      getUsers();
    }
  }

  Future<void> getUsers() async {
    var url = Uri.http(Configure.server, "order");
    var resp = await http.get(url);
    setState(() {
      _orderList = orderFromJson(resp.body);
      mainBody = showUsers();
    });
    return;
  }

  Future<void> removeUsers(order) async {
    var url = Uri.http(Configure.server, "order/${order.id}");
    var resp = await http.delete(url);
    print(resp.body);
    return;
  }

  Widget showUsers() {
    return ListView.builder(
        itemCount: _orderList.length,
        itemBuilder: (context, index) {
          Order order = _orderList[index];
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            child: Card(
                child: ListTile(
              title: Text("${order.name}"),
              subtitle: Text("${order.size}"),
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => TshirtInfo(),
                //         settings: RouteSettings(arguments: order)));
              }, // to show info
              trailing: IconButton(
                  onPressed: () async {
                    String result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TshirtInfo(),
                            settings: RouteSettings(arguments: order)));
                    if (result == "refresh") {
                      getUsers();
                    }
                  },
                  icon: Icon(Icons.edit)),
            )),
            onDismissed: (direction) {
              removeUsers(order);
            }, // to delete
            background: Container(
              color: Colors.red,
              margin: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerRight,
              child: Icon(Icons.delete, color: Colors.white),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: Color(0xFF2E2E2E),
      ),
      drawer: SideMenu(),
      body: mainBody,
    );
  }
}
