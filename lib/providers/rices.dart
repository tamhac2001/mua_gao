import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';


class Rice {
  static int totalRice=0;
  late final String id;
  final String title;
  final String typeId;
  final int price;
  final int weight;
  late int quantity;
  final String description;
  final String imageUrl;
  late final double value;
  Rice({
    required this.title,
    required this.typeId,
    required this.price,
    required this.weight,
    required this.description,
    required this.imageUrl,
  }) {
    this.id =  'R' + RicesList.totalRice.toString();
    RicesList.totalRice++;
    this.value = price.toDouble() / weight;
    this.quantity = Random().nextInt(5) + 1;
    // this.quantity = 3;
  }
}

final ricesListProvider = StateNotifierProvider<RicesList, List<Rice>>(
        (ref) {
          // final typesList = ref.watch(typesOfRiceListProvider);
      return RicesList(
        [
          Rice(
              title: 'Gạo Cỏ May Hương Sen túi 10kg',
              typeId: 'T1',
              price: 260,
              weight: 10,
              description:
              'Gạo Cỏ May Hương Sen túi 10kg sử dụng giống gạo ngon ST được tuyển chọn kỹ lưỡng và canh tác theo quy trình an toàn, đảm bảo mang lại những hạt gạo trắng đều, đẹp và có hương sen thơm nhẹ. Khi nấu gạo cho cơm dẻo mềm vừa ăn, thơm thoang thoảng.',
              imageUrl: 'https://sieuthigao.vn/wp-content/uploads/2020/11/gao-co-may-huong-sen-5kg.jpg'),
          Rice(
              title: 'Gạo Cỏ May Long Châu 66 lúa tôm túi 5kg',
              typeId: 'T1',
              price: 175,
              weight: 5,
              description:
              'Gạo Cỏ May Long Châu 66 lúa tôm túi 5kg hút chân không sử dụng giống gạo ngon ST25 được tuyển chọn kỹ lưỡng và canh tác theo quy trình an toàn, đảm bảo mang lại những hạt gạo thơm, cơm ngọt, mềm và dẻo dai cơm.',
              imageUrl: 'https://sieuthigao.vn/wp-content/uploads/2020/11/gao-co-may-long-chau-66-lua-tom-tui-5kg-1.png'),
          Rice(
              title: 'Gạo Cỏ May Ngọc Sa túi 5kg hút chân không',
              typeId: 'T1',
              price: 165,
              weight: 5,
              description:
              'Gạo Cỏ May Ngọc Sa túi 5kg hút chân không sử dụng giống gạo ngon ST được tuyển chọn kỹ lưỡng và canh tác theo quy trình an toàn, đảm bảo mang lại những hạt gạo thơm, vị ngọt cơm, mềm và dẻo dai.',
              imageUrl: 'https://sieuthigao.vn/wp-content/uploads/2013/08/gao-co-may-ngoc-sa-tui-5-kg-hut-chan-khong.png'),
          Rice(
              title: 'Gạo Cỏ May túi 10kg',
              typeId: 'T1',
              price: 179,
              weight: 10,
              description:
              'Gạo Cỏ May túi 10kg có mùi thơm nhẹ và hạt cơm dẻo vừa. Gạo được trồng từ giống lúa tuyển chọn vùng Đồng Bằng Sông Cửu Long',
              imageUrl:
              'https://sieuthigao.vn/wp-content/uploads/2020/11/gao-co-may-tui-10kg-gao-thom-com-deo-vua-that-ngon.png'),
          Rice(
              title: 'Gạo Hạt Ngọc Trời Bắc Đẩu túi 5kg',
              typeId: 'T1',
              price: 150,
              weight: 5,
              description:
              'Gạo Hạt Ngọc Trời Bắc Đẩu là giống lúa xưa của vùng Thất Sơn, bảy núi An Giang. Được nghiên cứu và phục tráng từ các kỹ sư Tập đoàn Lộc Trời, đã trở thành giống lúa mùa trồng trên vuông tôm. Cây lúa hấp thụ phế phẩm từ con tôm mà phát triển khỏe mạnh, hạt lúa vì thế mà vượt trội hơn. Con tôm nhờ cây lúa mà có được môi trường sinh trưởng an toàn. Tạo thành một hệ sinh thái thuần tự nhiên trên vùng nguyên liệu theo tiêu chuẩn quốc tế SRP đầu tiên tại Việt Nam. Kết hợp với lực lượng kỹ sư nông nghiệp Ba Cùng đồng hành với bà con nông dân',
              imageUrl: 'https://sieuthigao.vn/wp-content/uploads/2020/11/gao-hat-ngoc-troi-bac-dau-tui-5kg.png'),
          Rice(
              title: 'Gạo Hạt Ngọc Trời Bạch Dương túi 5kg',
              typeId: 'T1',
              price: 109,
              weight: 10,
              description:
              'Gạo Hạt Ngọc Trời Bạch Dương là sản phẩm được sản xuất trên giống lúa thuần thuộc khu vực ven biển do Tập đoàn Lộc Trời nghiên cứu. Được canh tác theo quy trình sản xuất lúa gạo bền vững quốc tế SRP đầu tiên tại Việt Nam. Bên cạnh sự sát cánh thường trực của các kỹ sư nông nghiệp Ba Cùng, đảm bảo cho người nông dân thực hành đầy đủ các nguyên tắc sản xuất an toàn. Gạo Bạch Dương được kiểm soát và đóng gói đạt các tiêu chuẩn quốc tế BRC – tiêu chuẩn an toàn thực phẩm Anh cùng các tiêu chuẩn xuất khẩu quốc tế khác.\nGạo Hạt Ngọc Trời Bạch Dương là sự kết hợp giữa giống lúa và vùng trồng duyên hải nên cơm có vị đậm đà của biển, dẻo, mềm, mùi thơm lài, vị ngọt đặc trưng phù hợp với đa số khẩu vị của người Việt Nam.',
              imageUrl: 'https://sieuthigao.vn/wp-content/uploads/2020/11/gao-hat-ngoc-troi-bach-duong-tui-5kg.png'),
          Rice(
              title: 'Gạo Hạt Ngọc Trời Nhật Nguyên túi 10kg',
              typeId: 'T1',
              price: 185,
              weight: 10,
              description:
              'Gạo Hạt Ngọc Trời Nhật Nguyên được trồng trên vùng nguyên liệu lúa gạo bền vững quốc tế SRP, thực hiện đầu tiên tại Việt Nam, được giám sát trực tiếp bởi lực lượng kỹ sư nông nghiêp Ba Cùng của tập đoàn Lộc Trời, kết hợp cùng dây chuyền sản xuất hiện đại khép kín đạt chuẩn tiêu chuẩn an toàn vệ sinh thực phẩm Châu Âu BRC và các tiêu chuẩn quốc tế khác. Gạo Nhật Nguyên cho cơm dẻo vừa, ít nở hạt mềm, cơm có mùi thơm lài nhẹ, khi ăn có hậu vị ngọt.',
              imageUrl: 'https://sieuthigao.vn/wp-content/uploads/2020/11/gao-hat-ngoc-troi-nhat-nguyen-tui-10kg.png'),
        ],
      );
    }
);
final sortedRicesListProvider = Provider<List<Rice>>((ref) {
  final riceList = ref.watch(ricesListProvider);
  riceList.sort((a, b) => a.value.compareTo(b.value));
  return riceList.reversed.toList();
});
final riceByIdProvider = Provider.autoDispose.family<Rice, String>((ref, id) {
  return ref.watch(ricesListProvider).firstWhere((currentRice) => currentRice.id == id);
});
final riceByIndexProvider = Provider.autoDispose.family<Rice, int>((ref, index) {
  return ref.watch(ricesListProvider).elementAt(index);
});

final moneyWantToSpendProvider = StateProvider<int>((ref) => 0);

class RicesList extends StateNotifier<List<Rice>> {
  RicesList([List<Rice>? initialList]) : super(initialList ?? []);
  static int totalRice = 0;

}
