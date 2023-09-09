// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, avoid_print

import 'dart:convert';

import 'package:finalproject_t_shop/models/config.dart';
import 'package:finalproject_t_shop/models/users.dart';
import 'package:finalproject_t_shop/user/userinfo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserEdit extends StatefulWidget {
  const UserEdit({super.key});

  @override
  State<UserEdit> createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  final _formkey = GlobalKey<FormState>();
  // Users user = Users();
  late Users user;

  Future<void> updateData(user) async {
    var url = Uri.http(Configure.server, "users/${user.id}");
    var resp = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(user.toJson()),
    );
    var rs = usersFromJson("[${resp.body}]");
    if (rs.length == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserInfo(),
              settings: RouteSettings(arguments: user)));
    }
  }

  Widget passwordEdit() {
    return TextFormField(
      initialValue: user.password,
      decoration:
          InputDecoration(labelText: "Password:", border: OutlineInputBorder()),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => user.password = newValue,
    );
  }

  Widget fnameEdit() {
    return TextFormField(
      initialValue: user.firstname,
      decoration: InputDecoration(
          labelText: "Firstname:", border: OutlineInputBorder()),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => user.firstname = newValue,
    );
  }

  Widget lnameEdit() {
    return TextFormField(
      initialValue: user.lastname,
      decoration:
          InputDecoration(labelText: "Lastname:", border: OutlineInputBorder()),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => user.lastname = newValue,
    );
  }

  Widget phoneEdit() {
    return TextFormField(
      initialValue: user.phone,
      decoration:
          InputDecoration(labelText: "Phone:", border: OutlineInputBorder()),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => user.phone = newValue,
    );
  }

  Widget addressEdit() {
    return TextFormField(
      initialValue: user.address,
      decoration:
          InputDecoration(labelText: "Address:", border: OutlineInputBorder()),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => user.address = newValue,
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          print(user.toJson().toString());
          if (user.id == null) {
            print('This is not a user');
          } else {
            updateData(user);
          }
        }
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green, padding: const EdgeInsets.all(12.0)),
      child: Text("Save"),
    );
  }

  @override
  Widget build(BuildContext context) {
    try {
      user = ModalRoute.of(context)!.settings.arguments as Users;
      print(user);
    } catch (e) {
      user = Users();
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
          backgroundColor: Color(0xFF2E2E2E),
        ),
        body: ListView(
          children: [
            Card(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                            title: Center(
                                child: Text(
                          "Username: ${user.username}",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ))),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 10.0),
                          child: passwordEdit(),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 10.0),
                          child: fnameEdit(),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 10.0),
                          child: lnameEdit(),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 10.0),
                          child: phoneEdit(),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 10.0),
                          child: addressEdit(),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            submitButton(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
