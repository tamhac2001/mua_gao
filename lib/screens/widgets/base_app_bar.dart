import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/cart.dart';
import 'package:mua_gao/screens/cart_screen/cart_screen.dart';

AppBar buildBaseAppBar({required BuildContext context, required String title}) {
  return AppBar(
    title: Text(title),
    actions: [
      Consumer(builder: (context, ref, child) {
        final cartData = ref.watch(cartProvider);
        return Badge(
          showBadge: cartData.isNotEmpty,
          badgeContent: Text(cartData.length.toString()),
          position: BadgePosition.topEnd(top: 0, end: 0),
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
            icon: Icon(Icons.shopping_cart),
          ),
        );
      }),
      SizedBox(
        width: 16.0,
      )
    ],
  );
}
