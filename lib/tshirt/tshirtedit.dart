// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, unused_local_variable

import 'dart:convert';

import 'package:finalproject_t_shop/models/config.dart';
import 'package:finalproject_t_shop/models/order.dart';
import 'package:finalproject_t_shop/models/tshirt.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formkey = GlobalKey<FormState>();
  late Tshirt tshirt;
  late Order order;
  int _tshirtCount = 1;

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

  Future<void> updateData(order) async {
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

  Widget chooseSize() {
    var initGen = "S";
    try {
      if (order.size!.isEmpty) {
        initGen = order.size!;
      }
    } catch (e) {
      initGen = "S";
    }

    return DropdownButtonFormField(
        decoration: InputDecoration(border: OutlineInputBorder()),
        value: 'S',
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
    try {
      tshirt = ModalRoute.of(context)!.settings.arguments as Tshirt;
      print(tshirt.name);
    } catch (e) {
      tshirt = Tshirt();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tshirt Cart Edit"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [],
            )),
      ),
    );
  }
}
