import 'package:flutter/material.dart';
import 'package:mua_gao/providers/rices.dart';
import 'package:provider/provider.dart';

class RiceDetailScreen extends StatelessWidget {
  static final String routeName = '/rice_detail';
  final String bullet = "\u2022 ";

  @override
  Widget build(BuildContext context) {
    final riceId = ModalRoute.of(context)!.settings.arguments as String;
    final currentRice = Provider.of<Rices>(context).findById(riceId);
    return Scaffold(
      appBar: AppBar(
        title: Text(currentRice.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(currentRice.imageUrl),
            SizedBox(
              height: 32.0,
            ),
            Text(
              currentRice.title,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              currentRice.description,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.justify,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Con lai:',
                  style:
                      TextStyle(backgroundColor: Theme.of(context).accentColor,fontWeight: FontWeight.bold),
                ),
                Text(currentRice.quantity.toString(),style:TextStyle(fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
