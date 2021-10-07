import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mua_gao/providers/rices.dart';
import 'package:provider/provider.dart';

class RiceListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final riceData = Rices();
    for (Rice rice in riceData.riceListSortByValue) {
      print('In list:' + rice.id + ':' + rice.quantity.toString());
    }
    final riceCouldBuyData = Provider.of<RicesCouldBuy>(context);

    if (riceCouldBuyData.moneyWantToSpend > 0) {
      print(riceCouldBuyData.riceCouldBuy.length);
      return Flexible(
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8.0,),
          itemCount: riceCouldBuyData.riceCouldBuy.length,
          itemBuilder: (context, index) => Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              riceCouldBuyData.remove(riceCouldBuyData.riceCouldBuy.keys.elementAt(index));
            },
            child: Card(
              shadowColor: null,
              child: ExpansionTile(
                initiallyExpanded: true,
                expandedAlignment: Alignment.centerLeft,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(riceData.findById(riceCouldBuyData.riceCouldBuy.keys.elementAt(index)).imageUrl),
                ),
                title: Text(riceData.findById(riceCouldBuyData.riceCouldBuy.keys.elementAt(index)).title),
                // subtitle: Text('Số lượng mua: ' + riceCouldBuyData.riceCouldBuy.values.elementAt(index).toString() + ' bịch'),
                trailing: Chip(
                  backgroundColor: Theme.of(context).primaryColor,
                  label: Text(
                    formattedMoneyForDisplay((riceCouldBuyData.getMoneyToBuyRice(index))),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                children: [
                  Text('Đơn giá: ' + formattedMoneyForDisplay(riceCouldBuyData.getRiceByIndex(index).price)),
                  Text('Số hàng trong kho: ' + riceCouldBuyData.getRiceByIndex(index).quantity.toString() + ' bịch'),
                  Text('Số lượng mua: ' + riceCouldBuyData.riceCouldBuy.values.elementAt(index).toString() + ' bịch'),
                  Text('Tổng khối lượng: ' + riceCouldBuyData.getTotalWeightOfRice(index).toString() + ' kg')
                ],
              ),
            ),
          ),
        ),
      );
    } else
      return Container();
  }
}

String formattedMoneyForDisplay(int money) {
  final numberFormat = NumberFormat('###,###');
  return numberFormat.format(money).replaceAll(',', '.') + '.000 đ';
}
