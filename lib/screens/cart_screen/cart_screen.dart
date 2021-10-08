import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mua_gao/providers/Cart.dart';
import 'package:mua_gao/providers/rices.dart';
import 'package:mua_gao/screens/widgets/rice_list_view.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static final String routeName = '/cart';
  final ricesData = Rices();

  @override
  Widget build(BuildContext context) {
    final _cartData = Provider.of<Cart>(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ..._cartData.items.entries.map((item) {
                final currentRice = ricesData.findById(item.key);
                return Card(
                  child: ExpansionTile(
                    // initiallyExpanded: true,
                    expandedAlignment: Alignment.centerLeft,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(currentRice.imageUrl),
                    ),
                    title: Text(item.value.title),
                    subtitle: Text(
                      formattedPriceForDisplay(item.value.getTotalPrice()),
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Colors.red[400],
                          ),
                    ),
                    children: [
                      Text('Đơn giá: ' + formattedPriceForDisplay(item.value.price)),
                      Text('Số lượng mua: ' + item.value.quantity.toString() + ' bịch'),

                    ],
                  ),
                );
              }).toList()
            ],
          ),
        ),
      ),
    ));
  }
}

String formattedPriceForDisplay(int price) {
  final numberFormat = NumberFormat('###,###');
  return numberFormat.format(price).replaceAll(',', '.') + '.000 đ';
}
