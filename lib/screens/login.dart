// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, non_constant_identifier_names

import 'package:finalproject_t_shop/models/config.dart';
import 'package:finalproject_t_shop/models/users.dart';
import 'package:finalproject_t_shop/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  static const routeName = "/login";

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  Users user = Users();

  Future<void> login(Users user) async {
    var params = {"username": user.username, "password": user.password};
    var url = Uri.http(Configure.server, "users", params);
    var resp = await http.get(url);
    print(resp.body);
    List<Users> login_result = usersFromJson(resp.body);
    print(login_result.length);
    if (login_result.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Username or Password is Invalid")));
    } else {
      Configure.login = login_result[0];
      Navigator.pushNamed(context, Home.routeName);
    }
    return;
  }

  Widget header() {
    return Center(
      child: Container(
        padding:
            const EdgeInsets.all(40.0), // เพิ่ม padding หรือขอบให้กับข้อความ
        decoration: BoxDecoration(
            color: Color(0xFF2E2E2E) // กำหนดสีพื้นหลังของ Container
            ),
        child: Text(
          'T_Sh0p',
          style: TextStyle(color: Colors.white, fontSize: 60.0 // กำหนดสีข้อความ
              ),
        ),
      ),
    );
  }

  Widget usernameInputField() {
    return TextFormField(
      initialValue: 'tuser1',
      decoration:
          InputDecoration(labelText: "Username:", border: OutlineInputBorder()),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => user.username = newValue,
    );
  }

  Widget passwordInputField() {
    return TextFormField(
      initialValue: 'tu111',
      obscureText: true,
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

  Widget loginButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          print(user.toJson().toString());
          login(user);
        }
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF2E2E2E),
          padding: const EdgeInsets.all(12.0)),
      child: Text("Login"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context)
              .size
              .width, // กว้างเท่ากับความกว้างของจอภาพ
          height:
              MediaQuery.of(context).size.height, // สูงเท่ากับความสูงของจอภาพ
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // จัดวางแนวตั้งตรงกลาง
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                SizedBox(height: 30.0),
                usernameInputField(),
                SizedBox(height: 20.0),
                passwordInputField(),
                SizedBox(height: 20.0),
                Center(child: loginButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
