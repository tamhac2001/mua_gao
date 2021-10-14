import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mua_gao/providers/types_of_rice.dart';
import 'package:mua_gao/providers/rices.dart';

import 'package:mua_gao/screens/widgets/base_app_bar.dart';

class RiceDetailScreen extends ConsumerWidget {
  static final String routeName = '/rice_detail';
  final String bullet = "\u2022 ";

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final riceId = ModalRoute.of(context)!.settings.arguments as String;
    final currentRice = ref.watch(riceByIdProvider(riceId));
    final typeOfRice = ref.watch(typeOfRiceByTypeIdProvider(currentRice.typeId));
    return SafeArea(
      child: Scaffold(
        appBar: buildBaseAppBar(context: context,title:  currentRice.title),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(currentRice.imageUrl),
              SizedBox(
                height: 32.0,
              ),
              Text(
                currentRice.title,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.green
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                formattedPriceForDisplay(currentRice.price),
                style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.red[400],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                'Loại gạo: '+typeOfRice.title,
                style: Theme.of(context).textTheme.bodyText2
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                currentRice.description,
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Số hàng trong kho:',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(currentRice.quantity.toString()+' bịch',style:TextStyle(fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String formattedPriceForDisplay(int price){
    final numberFormat = NumberFormat('###,###');
    return numberFormat.format(price).replaceAll(',', '.') + '.000 đ';
  }
}
