import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mua_gao/providers/rices.dart';
import 'package:mua_gao/screens/rice_detail_screen/rice_detail_screen.dart';
import 'package:mua_gao/screens/widgets/base_app_bar.dart';
import 'package:mua_gao/screens/widgets/bottom_nav.dart';
import 'package:provider/provider.dart';

class RicesOverviewScreen extends StatelessWidget {
  static final routeName = '/';

  @override
  Widget build(BuildContext context) {
    final rices = Provider.of<Rices>(context);

    return Scaffold(
      appBar: buildBaseAppBar(),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: rices.riceListSortByValue.length,
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: rices.riceListSortByValue[index], child: RiceGridTile()),
      ),
      bottomNavigationBar: BottomNav(routeName),
    );
  }
}

class RiceGridTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rice = Provider.of<Rice>(context);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RiceDetailScreen.routeName,
            arguments: rice.id);
      },
      child: GridTile(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: Image.network(rice.imageUrl)),
            Text(
              rice.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
