// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors

import 'package:finalproject_t_shop/models/order.dart';
import 'package:flutter/material.dart';

class addToCart extends StatefulWidget {
  const addToCart({super.key});

  @override
  State<addToCart> createState() => _addToCartState();
}

class _addToCartState extends State<addToCart> {
  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as Order;

    return Scaffold(
        appBar: AppBar(
          title: Text("Add to Cart"),
        ),
        body:
            Text("${order.name} ${order.price} ${order.size} ${order.count}"));
  }
}
