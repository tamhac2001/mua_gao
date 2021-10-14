import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mua_gao/providers/cart.dart';
import 'package:mua_gao/providers/rices.dart';
import 'package:mua_gao/providers/rices_could_buy.dart';
import 'package:mua_gao/screens/widgets/base_app_bar.dart';
import 'package:mua_gao/screens/widgets/bottom_nav.dart';

import 'rice_list_view.dart';

class RicesCalculateScreen extends ConsumerWidget {
  static final routeName = '/rices_calculate';
  final numberFormat = NumberFormat('###,###');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _riceCouldBuy = ref.watch(ricesCouldBuyMapProvider);
    final _moneyWantToSpend = ref.watch(moneyWantToSpendProvider);
    return SafeArea(
      child: Scaffold(
        appBar: buildBaseAppBar(context: context, title: 'Mua nhiều nhất theo số tiền'),
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
                      child: MyTextFormField(),
                    ),
                    Text('VND'),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Visibility(
                  visible: _moneyWantToSpend.state > 0,
                  child: Text('Với số tiền đó có thể mua được khối lượng gạo nhiều nhất là:',
                      style: Theme.of(context).textTheme.headline6),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Flexible(child: RiceListView()),
                const SizedBox(
                  height: 16.0,
                ),
                if (_moneyWantToSpend.state > 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tổng cộng: ' + ref.watch(totalWeightCouldBuyProvider).toString() + ' kg',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Chip(
                          backgroundColor: Theme.of(context).primaryColor,
                          label: Text(
                            formattedMoneyForDisplay(ref.watch(totalMoneySpend)),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 8.0,
                ),
                Visibility(
                  visible: _riceCouldBuy.isNotEmpty,
                  child: ElevatedButton(
                    onPressed:()=> onPressed(ref),
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

  void onPressed(WidgetRef ref) {
    ref.read(ricesCouldBuyMapProvider).forEach((riceId, quantity) {
      Rice currentRice = ref.read(riceByIdProvider(riceId));
      ref
          .read(cartProvider.notifier)
          .addItem(riceId, currentRice.title, currentRice.price, currentRice.quantity);
    });
    ref.read(ricesCouldBuyMapProvider.notifier).clear();
  }

  String formattedMoneyForDisplay(int money) {
    final numberFormat = NumberFormat('###,###');
    return numberFormat.format(money).replaceAll(',', '.') + '.000 đ';
  }
}

class MyTextFormField extends ConsumerWidget {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _moneyWantToSpend = ref.watch(moneyWantToSpendProvider);

    return TextFormField(
      textAlign: TextAlign.center,
      decoration: const InputDecoration(border: const UnderlineInputBorder(), hintText: 'VD: 1.000.000'),
      controller: _textController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null) return '';
        value = value.replaceAll('.', '');
        if (int.tryParse(value) == null) {
          return 'Xin hãy nhập số tiền hợp lệ!';
        }
      },
      onChanged: onChanged,
      onFieldSubmitted: (value) {
        value = value.replaceAll('.', '');
        print(int.parse(value) ~/ 1000);
        _moneyWantToSpend.state = (int.parse(value) ~/ 1000);
        _textController.text = formattedMoneyForDisplay(int.parse(value) ~/ 1000).replaceAll(' đ', '');
        print('totalMoney:' + _moneyWantToSpend.state.toString());
        ref.read(ricesCouldBuyMapProvider.notifier).updateRiceCouldBuy();
      },
    );
  }

  void onChanged(value) {
    final numberFormat = NumberFormat('###,###');
    value = value.replaceAll('.', '');
    if (value.isNotEmpty && int.tryParse(value) != null) {
      _textController.text = numberFormat.format(int.parse(value.replaceAll('.', ''))).toString().replaceAll(',', '.');
      _textController.selection = TextSelection.fromPosition(TextPosition(offset: _textController.text.length));
    }
  }
}
