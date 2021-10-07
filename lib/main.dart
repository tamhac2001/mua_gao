import 'package:flutter/material.dart';
import 'package:mua_gao/models/types_of_rice.dart';

import 'package:mua_gao/providers/rices.dart';
import 'package:mua_gao/screens/rice_detail_screen/rice_detail_screen.dart';
import 'package:mua_gao/screens/rices_calculate_screen/rices_calculate_screen.dart';
import 'package:mua_gao/screens/rices_overview_screen/rices_overview_screen.dart';
import 'package:provider/provider.dart';

import 'screens/widgets/bottom_nav.dart';

void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Rices(),),
        ChangeNotifierProvider(create: (context) => RicesCouldBuy(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App mua gao',
        home: RicesOverviewScreen(),
        routes: {
          RiceDetailScreen.routeName: (context) => RiceDetailScreen(),
          RicesCalculateScreen.routeName: (context) => RicesCalculateScreen(),

        },
      ),
    );
  }
}
