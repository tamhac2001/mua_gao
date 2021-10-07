import 'package:flutter/material.dart';

AppBar buildBaseAppBar() {
  return AppBar(
    title: Text('Gao'),
    actions: [
      IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))
    ],
  );
}