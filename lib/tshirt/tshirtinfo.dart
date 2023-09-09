// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print, unnecessary_type_check, use_build_context_synchronously, unnecessary_null_comparison, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:finalproject_t_shop/models/config.dart';
import 'package:finalproject_t_shop/models/order.dart';
import 'package:finalproject_t_shop/models/tshirt.dart';

class TshirtInfo extends StatefulWidget {
  static const routeName = "/tshirt";

  const TshirtInfo({Key? key}) : super(key: key);

  @override
  State<TshirtInfo> createState() => _TshirtInfoState();
}

class _TshirtInfoState extends State<TshirtInfo> {
  final _formKey = GlobalKey<FormState>();
  late Tshirt tshirt;
  late Order order;
  int _tshirtCount = 1;

  @override
  void initState() {
    super.initState();
    order = Order();
    tshirt = Tshirt();
  }

  Widget chooseSize() {
    var initGen = "S";
    try {
      if (order.size != null && order.size!.isNotEmpty) {
        initGen = order.size!;
      }
    } catch (e) {
      initGen = "S";
    }

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(border: OutlineInputBorder()),
      value: initGen,
      items: Configure.size.map((String val) {
        return DropdownMenuItem<String>(value: val, child: Text(val));
      }).toList(),
      onChanged: (String? value) {
        if (value != null) {
          order.size = value;
        }
      },
      onSaved: (String? newValue) {
        if (newValue != null) {
          order.size = newValue;
        }
      },
    );
  }

  Widget countTshirt() {
    void _incrementTshirt() {
      setState(() {
        _tshirtCount++;
      });
    }

    void _decrementTshirt() {
      if (_tshirtCount > 1) {
        setState(() {
          _tshirtCount--;
        });
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: _decrementTshirt,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            padding: EdgeInsets.all(12.0),
            child: Icon(
              Icons.remove,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(width: 20.0),
        Text(
          '$_tshirtCount',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 20.0),
        InkWell(
          onTap: _incrementTshirt,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            padding: EdgeInsets.all(12.0),
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> addOrder(BuildContext context, Order order) async {
    var url = Uri.http(Configure.server, '/order');
    var resp = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(order.toJson()),
    );
    var rs = orderFromJson("[${resp.body}]");
    if (rs.length == 1) {
      Navigator.pushNamed(context, '/addtocart');
    }
    return;
  }

  Widget addOrderButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          order.name = tshirt.name;
          order.price = tshirt.price;
          order.img = tshirt.img;
          order.count = _tshirtCount;
          order.totalprice = (tshirt.price! * _tshirtCount);
          order.status = "pending";
          print(order.toJson());
          addOrder(context, order);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.all(20.0),
      ),
      child: Text("Order"),
    );
  }

  @override
  Widget build(BuildContext context) {
    tshirt = ModalRoute.of(context)!.settings.arguments as Tshirt;
    var imgUrl = tshirt.img ??
        'https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-20.jpg';

    return Scaffold(
      appBar: AppBar(
        title: Text("T-Shirt Detail"),
        backgroundColor: Color(0xFF2E2E2E),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Card(
            child: ListView(
              children: [
                SizedBox(height: 15.0),
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(imgUrl),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Divider(height: 2.0, color: Colors.black),
                ),
                ListTile(
                  title: Text("T-Shirt Name", style: TextStyle(fontSize: 15)),
                  subtitle: Text("${tshirt.name}"),
                ),
                ListTile(
                  title: Text("T-Shirt Description"),
                  subtitle: Text("${tshirt.description}"),
                ),
                ListTile(
                  title: Text("T-Shirt Price"),
                  subtitle: Text("${tshirt.price} THB"),
                ),
                ListTile(
                  title: Text("T-Shirt Size"),
                  subtitle: chooseSize(),
                ),
                SizedBox(height: 10),
                ListTile(subtitle: countTshirt()),
                SizedBox(height: 10),
                ListTile(subtitle: addOrderButton(context))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
