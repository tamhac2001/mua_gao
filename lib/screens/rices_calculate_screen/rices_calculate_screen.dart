import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mua_gao/providers/rices.dart';
import 'package:mua_gao/screens/widgets/base_app_bar.dart';
import 'package:mua_gao/screens/widgets/bottom_nav.dart';
import 'package:provider/provider.dart';

import 'widgets/rice_list_view.dart';

class RicesCalculateScreen extends StatelessWidget {
  static final routeName = '/rices_calculate';
  final _textController = TextEditingController();
  final numberFormat = NumberFormat('###,###');

  @override
  Widget build(BuildContext context) {
    final riceCouldBuyData = Provider.of<RicesCouldBuy>(context);

    return Scaffold(
      appBar: buildBaseAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Nhập vào số tiền muốn mua:'),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _textController,
                    keyboardType: TextInputType.number,
                    onChanged: onChanged,
                    onFieldSubmitted: (value) {
                      value = value.replaceAll('.', '');
                      if (int.tryParse(value) == null) {
                        Fluttertoast.showToast(
                            msg: 'Xin hãy nhập số tiền hợp lệ!',
                            textColor: Colors.red,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER);
                      }
                      riceCouldBuyData.updateMoneyWantToSpend(int.parse(value) / 1000);
                      _textController.text = numberFormat.format(value).replaceAll(',', '.');
                      print('totalMoney:' + riceCouldBuyData.moneyWantToSpend.toString());
                    },
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(border: const UnderlineInputBorder(), hintText: 'VD: 1.000.000'),
                  ),
                ),
                Text('VND'),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Consumer<RicesCouldBuy>(
              builder: (context, value, child) => Visibility(
                visible: value.moneyWantToSpend > 0,
                child: Text(
                  'Với số tiền đó có thể mua được khối lượng gạo nhiều nhất là:',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            RiceListView(),
            const SizedBox(
              height: 16.0,
            ),
            if (riceCouldBuyData.moneyWantToSpend > 0)
              Consumer<RicesCouldBuy>(
                builder: (context, value, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tong cong:'),
                    Chip(
                      backgroundColor: Theme.of(context).primaryColor,
                      label: Text(
                        numberFormat.format(value.getTotalMoneySpend()).replaceAll(',', '.') + '.000 d',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(RicesCalculateScreen.routeName),
    );
  }

  void onChanged(value) {
    if (value.isNotEmpty) {
      _textController.text = numberFormat.format(int.parse(value.replaceAll('.', ''))).toString().replaceAll(',', '.');
      _textController.selection = TextSelection.fromPosition(TextPosition(offset: _textController.text.length));
    }
  }
}
