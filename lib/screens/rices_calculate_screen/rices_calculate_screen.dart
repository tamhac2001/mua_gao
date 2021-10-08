import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mua_gao/providers/Cart.dart';
import 'package:mua_gao/providers/rices.dart';
import 'package:mua_gao/screens/widgets/base_app_bar.dart';
import 'package:mua_gao/screens/widgets/bottom_nav.dart';
import 'package:provider/provider.dart';

import '../widgets/rice_list_view.dart';

class RicesCalculateScreen extends StatelessWidget {
  static final routeName = '/rices_calculate';
  final _textController = TextEditingController();
  final numberFormat = NumberFormat('###,###');
  final riceData = Rices();

  @override
  Widget build(BuildContext context) {
    final riceCouldBuyData = Provider.of<RicesCouldBuy>(context);
    final _cartData =Provider.of<Cart>(context);

    return SafeArea(
      child: Scaffold(
        appBar: buildBaseAppBar(context: context,title: 'Mua nhiều nhất theo số tiền'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Nhập vào số tiền muốn mua:',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _textController,
                        keyboardType: TextInputType.number,
                        onChanged: onChanged,
                        onFieldSubmitted: (value) {
                          print('value before format:' + value);
                          value = value.replaceAll('.', '');
                          if (int.tryParse(value) == null) {
                            Fluttertoast.showToast(
                                msg: 'Xin hãy nhập số tiền hợp lệ!',
                                textColor: Colors.red,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER);
                          } else {
                            print(int.parse(value) ~/ 1000);
                            riceCouldBuyData.updateMoneyWantToSpend(int.parse(value) ~/ 1000);
                            _textController.text =
                                formattedMoneyForDisplay(int.parse(value) ~/ 1000).replaceAll(' đ', '');
                            print('totalMoney:' + riceCouldBuyData.moneyWantToSpend.toString());
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration:
                            const InputDecoration(border: const UnderlineInputBorder(), hintText: 'VD: 1.000.000'),
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
                    child: Text('Với số tiền đó có thể mua được khối lượng gạo nhiều nhất là:',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Flexible(child: RiceListView(riceCouldBuyData.riceCouldBuy)),
                const SizedBox(
                  height: 16.0,
                ),
                if (riceCouldBuyData.moneyWantToSpend > 0)
                  Consumer<RicesCouldBuy>(
                    builder: (context, value, child) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tổng cộng: ' + value.getTotalWeightCouldBuy().toString() + ' kg',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Chip(
                            backgroundColor: Theme.of(context).primaryColor,
                            label: Text(
                              formattedMoneyForDisplay(value.getTotalMoneySpend()),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 8.0,
                ),
                Visibility(
                  visible: riceCouldBuyData.riceCouldBuy.isNotEmpty,
                  child: ElevatedButton(
                    onPressed: () {
                      riceCouldBuyData.riceCouldBuy.forEach((riceId, quantity) {
                        Rice currentRice = riceData.findById(riceId);
                        _cartData.addItem(riceId,currentRice.title , currentRice.price, currentRice.quantity);
                      });
                      riceCouldBuyData.clear();
                    },
                    child: Text('Thêm vào giỏ'),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNav(RicesCalculateScreen.routeName),
      ),
    );
  }

  void onChanged(value) {
    value = value.replaceAll('.', '');
    if (value.isNotEmpty && int.tryParse(value) != null) {
      _textController.text = numberFormat.format(int.parse(value.replaceAll('.', ''))).toString().replaceAll(',', '.');
      _textController.selection = TextSelection.fromPosition(TextPosition(offset: _textController.text.length));
    }
  }

  String formattedMoneyForDisplay(int money) {
    final numberFormat = NumberFormat('###,###');
    return numberFormat.format(money).replaceAll(',', '.') + '.000 đ';
  }
}
