import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mua_gao/providers/rices.dart';
import 'package:mua_gao/providers/rices_could_buy.dart';

class RiceListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _sortedRiceList = ref.watch(sortedRicesListProvider);
    final _ricesCouldBuyMap = ref.watch(ricesCouldBuyMapProvider);
    for (Rice rice in _sortedRiceList) {
      print('In list:' + rice.id + ':' + rice.quantity.toString());
    }

    // if (riceCouldBuyData.moneyWantToSpend > 0) {
    print(_ricesCouldBuyMap.length);
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 8.0,
      ),
      itemCount: _ricesCouldBuyMap.length,
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
          _ricesCouldBuyMap.remove(_ricesCouldBuyMap.keys.elementAt(index));
        },
        child: Card(
          shadowColor: null,
          child: Consumer(
            builder: (context, ref, child) {
              final _currentRice = ref.read(riceByIndexProvider(index));
             return ExpansionTile(
                initiallyExpanded: true,
                expandedAlignment: Alignment.centerLeft,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(_currentRice.imageUrl),
                ),
                title: Text(_currentRice.title),
                // subtitle: Text('Số lượng mua: ' + displayData.values.elementAt(index).toString() + ' bịch'),
                trailing: Chip(
                  backgroundColor: Theme.of(context).primaryColor,
                  label: Text(
                    formattedMoneyForDisplay((ref.read(totalMoneyOfRiceCouldBuyByIndexProvider(index)))),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                children: [
                  Text('Đơn giá: ' + formattedMoneyForDisplay(_currentRice.price)),
                  Text('Số hàng trong kho: ' + _currentRice.quantity.toString() + ' bịch'),
                  Text('Số lượng mua: ' + _ricesCouldBuyMap.values.elementAt(index).toString() + ' bịch'),
                  Text('Tổng khối lượng: ' + ref.read(totalWeightOfRiceCouldBuyByIndexProvider(index)).toString() + ' kg')
                ],
              );
            },
          ),
        ),
      ),
    );
    // } else
    //   return Container();
  }
}

String formattedMoneyForDisplay(int money) {
  final numberFormat = NumberFormat('###,###');
  return numberFormat.format(money).replaceAll(',', '.') + '.000 đ';
}
