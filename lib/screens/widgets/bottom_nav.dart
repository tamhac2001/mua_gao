import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mua_gao/screens/rices_calculate_screen/rices_calculate_screen.dart';
import 'package:mua_gao/screens/rices_overview_screen/rices_overview_screen.dart';

class BottomNav extends StatefulWidget {
  final String routeName;
  BottomNav(this.routeName);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    final _currentIndex =
    (widget.routeName == RicesCalculateScreen.routeName) ? 1 : 0;


    return BottomNavigationBar(
      currentIndex: _currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.calculate), label: 'Calculate'),
      ],
      onTap: (value) {
        setState(() {
          // Fluttertoast.showToast(msg: 'Xin hãy nhập số tiền hợp lệ!',toastLength: Toast.LENGTH_LONG);
          if (value != _currentIndex) {
            if (value == 0)
              Navigator.pushReplacementNamed(
                  context, RicesOverviewScreen.routeName);
            else
              Navigator.pushReplacementNamed(
                  context, RicesCalculateScreen.routeName);
          }
        });
      },
    );
  }
}
