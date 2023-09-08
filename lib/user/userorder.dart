// ignore_for_file: prefer_const_constructors

import 'package:finalproject_t_shop/models/config.dart';
import 'package:finalproject_t_shop/models/myorder.dart';
import 'package:finalproject_t_shop/models/users.dart';
import 'package:finalproject_t_shop/screens/sidemenu.dart';
import 'package:finalproject_t_shop/user/userorderdetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserOrder extends StatefulWidget {
  static const routeName = "/order";

  const UserOrder({super.key});

  @override
  State<UserOrder> createState() => _UserOrderState();
}

class _UserOrderState extends State<UserOrder> {
  Widget mainBody = Container();
  List<Myorder> _myorderList = [];

  @override
  void initState() {
    super.initState();
    Users user = Configure.login;
    if (user.id != null) {
      getMyOrder();
    }
  }

  Future<void> getMyOrder() async {
    Users user = Configure.login;
    var url = Uri.http(Configure.server, "myorder");
    var resp = await http.get(url);
    List<Myorder> allMyOrders = myorderFromJson(resp.body);

    // กรองรายการ Myorder ที่มี uid เท่ากับ id ของผู้ใช้
    _myorderList =
        allMyOrders.where((myorder) => myorder.uid == user.id).toList();

    setState(() {
      mainBody = showOrder();
    });
  }

  Widget showOrder() {
    if (_myorderList.isEmpty) {
      return Center(
        child: Text(
          "No My Order",
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: _myorderList.length,
        itemBuilder: (context, index) {
          Myorder myorder = _myorderList[index];
          var imgorder = myorder.img;
          imgorder ??=
              'https://t3.ftcdn.net/jpg/04/62/93/66/360_F_462936689_BpEEcxfgMuYPfTaIAOC1tCDurmsno7Sp.jpg';

          return Dismissible(
              key: UniqueKey(),
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text("#${myorder.id} - ${myorder.name ?? 'N/A'}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                              "Price: ${myorder.price != null ? '${myorder.price} THB' : 'N/A'}"),
                          const SizedBox(height: 5),
                          Text("Size: ${myorder.size ?? 'N/A'}"),
                          const SizedBox(height: 5),
                          Text("Count: ${myorder.count ?? 'N/A'}"),
                          const SizedBox(height: 5),
                          Text(
                              "Total Price: ${myorder.totalprice != null ? '${myorder.totalprice} THB' : 'N/A'}"),
                          const SizedBox(height: 5),
                        ],
                      ),
                      leading: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(imgorder),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UserOrderDetail(myOrder: myorder),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 20.0), // Adjust padding as needed
                          decoration: BoxDecoration(
                            color: Colors
                                .blue, // Change the button background color
                            borderRadius: BorderRadius.circular(
                                10.0), // Add rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Add a shadow
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset:
                                    const Offset(0, 3), // Offset of the shadow
                              ),
                            ],
                          ),
                          child: const Text(
                            "View Order Detail",
                            style: TextStyle(
                              color: Colors
                                  .white, // Change the text color to white
                              fontWeight: FontWeight
                                  .bold, // Adjust font weight as needed
                              fontSize: 14.0, // Adjust font size as needed
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Order"),
        backgroundColor: Color(0xFF2E2E2E),
      ),
      drawer: SideMenu(),
      body: mainBody,
    );
  }
}
