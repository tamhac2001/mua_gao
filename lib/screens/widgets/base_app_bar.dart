import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:mua_gao/providers/Cart.dart';
import 'package:mua_gao/screens/cart_screen/cart_screen.dart';
import 'package:provider/provider.dart';

AppBar buildBaseAppBar({required BuildContext context, required String title}) {
  return AppBar(
    title: Text(title),
    actions: [
      Consumer<Cart>(
        builder: (context, cartData, child) => Badge(
          showBadge: cartData.items.isNotEmpty,
          badgeContent: Text(cartData.items.length.toString()),
          position: BadgePosition.topEnd(top: 0, end: 0),
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ),
      ),
      SizedBox(
        width: 16.0,
      )
    ],
  );
}
