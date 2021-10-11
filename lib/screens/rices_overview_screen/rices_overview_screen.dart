import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mua_gao/providers/rices.dart';
import 'package:mua_gao/screens/rice_detail_screen/rice_detail_screen.dart';
import 'package:mua_gao/screens/widgets/base_app_bar.dart';
import 'package:mua_gao/screens/widgets/bottom_nav.dart';

class RiceOverviewScreen extends StatelessWidget {
  static final routeName = '/';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildBaseAppBar(context: context, title: 'Danh sách gạo'),
        body: Consumer(
          builder: (context, watch, child) {
            final ricesList = watch(ricesListProvider);
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: ricesList.length,
              itemBuilder: (context, index) => RiceGridTile(index),
            );
          },
        ),
        bottomNavigationBar: BottomNav(routeName),
      ),
    );
  }
}

class RiceGridTile extends ConsumerWidget {
  final riceIndex;

  RiceGridTile(this.riceIndex);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final rice = watch(ricesListProvider).elementAt(riceIndex);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RiceDetailScreen.routeName, arguments: rice.id);
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
