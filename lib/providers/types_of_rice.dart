import 'package:flutter_riverpod/flutter_riverpod.dart';

class TypeOfRice {
  final String id;
  final String title;
  final int numberOfRice;

  TypeOfRice({required this.id, required this.title, required this.numberOfRice});

// void increaseNumberOfRice() {
//   numberOfRice++;
// }

}

final typesOfRiceListProvider = StateNotifierProvider<TypesOfRiceList, List<TypeOfRice>>(
  (ref) => TypesOfRiceList(ref, [
    TypeOfRice(id: 'T1', title: 'Gao mem', numberOfRice: 0),
  ]),
);

final typeOfRiceByTypeIdProvider = Provider.autoDispose.family<TypeOfRice, String>((ref, id) {
  return ref.read(typesOfRiceListProvider).firstWhere((type) => type.id == id);
});

// final numberOfRiceByIdProvider = Provider.autoDispose.family<int,String>((ref,id){
//   return ref.read(typeOfRiceByTypeIdProvider(id)).numberOfRice;
// });
// final getTitleOfTypeByIdProvider = Provider.autoDispose.family<String,String>((ref,id){
//   return ref.read(typeOfRiceByTypeIdProvider(id)).title;
// });
class TypesOfRiceList extends StateNotifier<List<TypeOfRice>> {
  TypesOfRiceList(this.ref, [List<TypeOfRice>? initialList]) : super(initialList ?? []);

  final ProviderRefBase ref;

  void increaseNumberOfRice(String id) {
    state = [
      for (final type in state)
        if (type.id == id) TypeOfRice(id: type.id, title: type.title, numberOfRice: type.numberOfRice + 1) else type,
    ];
  }
}
