import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItem {
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

  int getTotalPrice() {
    return this.price * this.quantity;
  }
}


final cartProvider = StateNotifierProvider<Cart, Map<String, CartItem>>((ref) => Cart());

class Cart extends StateNotifier<Map<String, CartItem>> {
  Cart() : super({});

  void addItem(String riceId, String title, int price, int quantity) {
    state.update(
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
    state.removeWhere((key, value) => key == riceId);
  }

  void clear() {
    state = {};
  }
}
