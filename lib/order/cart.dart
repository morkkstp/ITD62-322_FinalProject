// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, sort_child_properties_last, avoid_print, camel_case_types

import 'package:finalproject_t_shop/models/config.dart';
import 'package:finalproject_t_shop/models/order.dart';
import 'package:finalproject_t_shop/models/users.dart';
import 'package:finalproject_t_shop/screens/sidemenu.dart';
import 'package:finalproject_t_shop/tshirt/tshirtedit.dart';
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
      getOrder();
    }
  }

  Future<void> getOrder() async {
    var url = Uri.http(Configure.server, "order");
    var resp = await http.get(url);
    setState(() {
      _orderList = orderFromJson(resp.body);
      mainBody = showUsers();
    });
    return;
  }

  Future<void> removeOrder(order) async {
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
          var imgUrl = order.img ??
              'https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-20.jpg';
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            child: Card(
                child: ListTile(
                    title: Text("${order.name}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(
                            "Price: ${order.price != null ? '${order.price} THB' : 'N/A'}"),
                        SizedBox(height: 5),
                        Text("Size: ${order.size ?? 'N/A'}"),
                        SizedBox(height: 5),
                        Text("Count: ${order.count ?? 'N/A'}"),
                        SizedBox(height: 5),
                        Text(
                            "Total Price: ${order.totalprice != null ? '${order.totalprice} THB' : 'N/A'}"),
                        SizedBox(height: 5),
                      ],
                    ),
                    leading: AspectRatio(
                        aspectRatio: 1, child: Image.network(imgUrl)),
                    trailing: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            String result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TshirtEdit(),
                                settings: RouteSettings(arguments: order),
                              ),
                            );
                            if (result == "refresh") {
                              getOrder();
                            }
                          },
                          child: Text('Edit',
                              style: TextStyle(color: Colors.blue)),
                        ),
                      ],
                    ))),
            onDismissed: (direction) {
              removeOrder(order);
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.shopping_basket),
        ));
  }
}
