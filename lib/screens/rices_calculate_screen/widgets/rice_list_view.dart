import 'package:flutter/material.dart';
import 'package:mua_gao/providers/rices.dart';
import 'package:provider/provider.dart';

class RiceListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final riceData = Provider.of<Rices>(context, listen: false);
    for (Rice rice in riceData.riceListSortByValue) {
      print('In list:' + rice.id + ':' + rice.quantity.toString());
    }
    final riceCouldBuyData = Provider.of<RicesCouldBuy>(context);

    if (riceCouldBuyData.moneyWantToSpend > 0) {
      riceCouldBuyData.updateRiceCouldBuy();
      final riceCouldBuyMap = riceCouldBuyData.riceCouldBuy;
      return Expanded(
        child: ListView.builder(
          itemCount: riceCouldBuyMap.length,
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
              riceCouldBuyMap.remove(riceCouldBuyMap.keys.elementAt(index));
            },
            child: Card(
              child: ExpansionTile(
                initiallyExpanded: true,
                expandedAlignment: Alignment.centerLeft,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(riceData.findById(riceCouldBuyMap.keys.elementAt(index)).imageUrl),
                ),
                title: Text(riceData.findById(riceCouldBuyMap.keys.elementAt(index)).title),
                // subtitle:
                trailing: Chip(
                  backgroundColor: Theme.of(context).primaryColor,
                  label: Text(
                    (riceData.findById(riceCouldBuyMap.keys.elementAt(index)).price *
                                riceData.findById(riceCouldBuyMap.keys.elementAt(index)).quantity)
                            .toString() +
                        '00 đ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                children: [
                  Text('Đơn giá: ' + riceCouldBuyData.getRiceByIndex(index).price.toString() + '000 đ'),
                  Text('Số hàng trong kho: ' +
                      riceData.findById(riceCouldBuyMap.keys.elementAt(index)).quantity.toString() +
                      ' bịch'),
                  Text('Số lượng mua: ' + riceCouldBuyMap.values.elementAt(index).toString() + ' bịch'),
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
