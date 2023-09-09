// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, unused_local_variable, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:finalproject_t_shop/models/config.dart';
import 'package:finalproject_t_shop/models/order.dart';
import 'package:finalproject_t_shop/models/tshirt.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TshirtEdit extends StatefulWidget {
  const TshirtEdit({super.key});

  @override
  State<TshirtEdit> createState() => _TshirtEditState();
}

class _TshirtEditState extends State<TshirtEdit> {
  final _formkey = GlobalKey<FormState>();
  late Tshirt tshirt;
  late Order order;

  int _tshirtCount = 1; // Declare _tshirtCount as a late int

  @override
  void initState() {
    super.initState();
    order = Order();
    tshirt = Tshirt();
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

  Future<void> updateOrder(order) async {
    var url = Uri.http(Configure.server, "order/${order.id}");
    var resp = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(order.toJson()));
    var rs = orderFromJson("[${resp.body}]");
    if (rs.length == 1) {
      Navigator.pop(context, "refresh");
    }
  }

  Widget updateOrderButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          order.name = order.name;
          order.price = order.price;
          order.img = order.img;
          order.count = _tshirtCount;
          order.totalprice = (order.price! * _tshirtCount);
          print(order.toJson());
          updateOrder(order);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.all(20.0),
      ),
      child: Text("Edit"),
    );
  }

  Widget chooseSize() {
    var initGen = "S";
    try {
      if (order.size!.isNotEmpty) {
        initGen = order.size!;
      }
    } catch (e) {
      initGen = "S";
    }

    return DropdownButtonFormField(
        decoration: InputDecoration(border: OutlineInputBorder()),
        value: initGen,
        items: Configure.size.map((String val) {
          return DropdownMenuItem(value: val, child: Text(val));
        }).toList(),
        onChanged: (value) {
          order.size = value;
        },
        onSaved: (newValue) => order.size);
  }

  @override
  Widget build(BuildContext context) {
    order = ModalRoute.of(context)!.settings.arguments as Order;
    var imgUrl = order.img ??
        'https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-20.jpg';

    try {
      order = ModalRoute.of(context)!.settings.arguments as Order;
      print(order.name);
    } catch (e) {
      order = Order();
    }
    return Scaffold(
      appBar: AppBar(
          title: const Text("Tshirt Cart Edit"),
          backgroundColor: Color(0xFF2E2E2E)),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(imgUrl),
                ),
                ListTile(
                  title: Text("T-Shirt Name", style: TextStyle(fontSize: 15)),
                  subtitle: Text("${order.name}"),
                ),
                ListTile(
                  title: Text("T-Shirt Count"),
                  subtitle: Text("${order.count}"),
                ),
                ListTile(
                  title: Text("T-Shirt Price"),
                  subtitle: Text("${order.price} THB"),
                ),
                ListTile(
                  title: Text("T-Shirt Size"),
                  subtitle: chooseSize(),
                ),
                SizedBox(height: 10),
                ListTile(subtitle: countTshirt()),
                SizedBox(height: 10),
                ListTile(subtitle: updateOrderButton(context))
              ],
            )),
      ),
    );
  }
}
