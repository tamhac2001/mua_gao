import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mua_gao/screens/cart_screen/cart_screen.dart';
import 'package:mua_gao/screens/rice_detail_screen/rice_detail_screen.dart';
import 'package:mua_gao/screens/rices_calculate_screen/rices_calculate_screen.dart';
import 'package:mua_gao/screens/rices_overview_screen/rices_overview_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (context) => Rices(),),
    //     ChangeNotifierProvider(create: (context) => RicesCouldBuy(),),
    //     ChangeNotifierProvider(create: (context) => Cart(),)
    //   ],
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
