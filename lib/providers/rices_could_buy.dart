import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mua_gao/providers/rices.dart';

final ricesCouldBuyMapProvider = StateNotifierProvider<RicesCouldBuy, Map<String, int>>((ref) => RicesCouldBuy(ref));
final totalWeightCouldBuyProvider = Provider<int>((ref) {
  int total = 0;
  final ricesCouldBuy = ref.watch(ricesCouldBuyMapProvider);
  ricesCouldBuy.forEach((key, quantity) {
    total += ref.read(riceByIdProvider(key)).weight * quantity;
  });
  return total;
});
final riceCouldBuyByIndexProvider = Provider.autoDispose.family<Rice, int>((ref, index) {
  final ricesCouldBuy = ref.watch(ricesCouldBuyMapProvider);
  return ref.read(riceByIdProvider(ricesCouldBuy.keys.elementAt(index)));
});
final totalWeightOfRiceCouldBuyByIndexProvider = Provider.autoDispose.family<int, int>((ref, index) {
  final currentRice = ref.read(riceCouldBuyByIndexProvider(index));
  final ricesCouldBuy = ref.watch(ricesCouldBuyMapProvider);
  return currentRice.weight * ricesCouldBuy.values.elementAt(index);
});
final totalMoneyOfRiceCouldBuyByIndexProvider = Provider.autoDispose.family<int, int>((ref, index) {
  final currentRice = ref.read(riceCouldBuyByIndexProvider(index));
  final ricesCouldBuy = ref.watch(ricesCouldBuyMapProvider);
  return currentRice.price * ricesCouldBuy.values.elementAt(index);
});
final totalMoneySpend = Provider<int>((ref) {
  int total = 0;
  final ricesCouldBuy = ref.watch(ricesCouldBuyMapProvider);
  ricesCouldBuy.forEach((key, quantity) {
    total += ref.read(riceByIdProvider(key)).price * quantity;
  });
  return total;
});

class RicesCouldBuy extends StateNotifier<Map<String, int>> {
  RicesCouldBuy(this.ref) : super({});

  final ProviderRefBase ref;

  void addRice(String riceId, int quantity) {
    state.putIfAbsent(riceId, () => quantity);
  }

  void updateRiceCouldBuy() {
    if (state.isNotEmpty) clear();
    final _riceSorted = ref.read(sortedRicesListProvider);
    int totalMoney = ref.read(moneyWantToSpendProvider).state;
    for (Rice rice in _riceSorted) {
      int counter = 0;
      while (counter < rice.quantity && totalMoney > rice.price) {
        totalMoney -= rice.price;
        counter++;
      }
      if (counter > 0) addRice(rice.id, counter);
    }
  }

  void clear() {
    state = {};
  }

// int? getQuantityCouldBuy(String key) {
//   return riceCouldBuy[key];
// }

// int getTotalQuantity() {
//   int total = 0;
//   _riceCouldBuy.forEach((key, value) {
//     total += value;
//   });
//   return total;
// }

}
