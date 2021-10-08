import 'package:flutter/material.dart';
import 'package:mua_gao/providers/rices.dart';

class CartItem with ChangeNotifier {
  final String id;
  final String title;
  int quantity;
  final price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });

  int getTotalPrice(){
    return this.price*this.quantity;
  }
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String riceId, String title, int price, int quantity) {
    _items.update(
      riceId,
      (currentItem) => CartItem(
          id: currentItem.id,
          title: currentItem.title,
          price: currentItem.price,
          quantity: currentItem.quantity + quantity),
      ifAbsent: () => CartItem(id: DateTime.now().toString(), title: title, price: price, quantity: quantity),
    );
  }

  void remove(String riceId) {
    _items.removeWhere((key, value) => key==riceId);
    notifyListeners();
  }

  void clear(){
    _items = {};
    notifyListeners();
  }
}
