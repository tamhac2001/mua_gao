import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mua_gao/screens/cart_screen/cart_screen.dart';
import 'package:mua_gao/screens/rice_detail_screen/rice_detail_screen.dart';
import 'package:mua_gao/screens/rices_calculate_screen/rices_calculate_screen.dart';
import 'package:mua_gao/screens/rices_overview_screen/rices_overview_screen.dart';

final providerContainer = ProviderContainer();
void main() {

  runApp(UncontrolledProviderScope(container: providerContainer,child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App mua gao',
      home: RiceOverviewScreen(),
      routes: {
        RiceDetailScreen.routeName: (context) => RiceDetailScreen(),
        RicesCalculateScreen.routeName: (context) => RicesCalculateScreen(),
        CartScreen.routeName: (context) => CartScreen(),
      },
    );
  }
}
