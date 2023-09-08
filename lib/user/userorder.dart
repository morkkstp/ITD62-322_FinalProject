// ignore_for_file: prefer_const_constructors

import 'package:finalproject_t_shop/models/config.dart';
import 'package:finalproject_t_shop/models/myorder.dart';
import 'package:finalproject_t_shop/models/users.dart';
import 'package:finalproject_t_shop/screens/sidemenu.dart';
import 'package:finalproject_t_shop/user/userorderdetail.dart';
import 'package:flutter/material.dart';

class UserOrder extends StatelessWidget {
  static const routeName = "/order";

  final Myorder myorder; // รับค่า myorder เป็นตัวแปรชนิด Myorder

  const UserOrder({Key? key, required this.myorder});

  @override
  Widget build(BuildContext context) {
    var myorder = ModalRoute.of(context)!.settings.arguments as Myorder;
    List<Myorder> myorderList = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Order"),
        backgroundColor: const Color(0xFF2E2E2E),
      ),
      drawer: SideMenu(),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: myorder.length,
        itemBuilder: (context, index) {
          var imgorder = myorder.img;
          imgorder ??=
              'https://t3.ftcdn.net/jpg/04/62/93/66/360_F_462936689_BpEEcxfgMuYPfTaIAOC1tCDurmsno7Sp.jpg';

          // เพิ่มเงื่อนไขเช็ค uid ของ myorder กับ id ใน Users
          if (Configure.login.id == myorder.uid) {
            return Card(
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         UserOrderDetail(myOrder: myorder),
                      //   ),
                      // );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 20.0), // Adjust padding as needed
                        decoration: BoxDecoration(
                          color:
                              Colors.blue, // Change the button background color
                          borderRadius: BorderRadius.circular(
                              10.0), // Add rounded corners
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Add a shadow
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 3), // Offset of the shadow
                            ),
                          ],
                        ),
                        child: Text(
                          "View Order Detail",
                          style: TextStyle(
                            color:
                                Colors.white, // Change the text color to white
                            fontWeight:
                                FontWeight.bold, // Adjust font weight as needed
                            fontSize: 14.0, // Adjust font size as needed
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            // ถ้า uid ไม่ตรงกับ id ใน Users ให้สร้าง ListTile เปล่า
            return ListTile();
          }
        },
      ),
    );
  }
}
