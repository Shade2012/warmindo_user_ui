

import 'package:get/get.dart';
import 'package:warmindo_user_ui/common/model/menu_model.dart';
import 'package:warmindo_user_ui/common/model/toppings.dart';
import 'package:warmindo_user_ui/common/model/varians.dart';

import '../../utils/themes/image_themes.dart';
import 'menu_list_API_model.dart';
import 'voucher_model.dart';

class Order {
  final int id;
  final int totalprice;
  final bool paid;
  final List<MenuList> menus;
  // final List<Voucher>? vouchers;
  String catatan;
  RxString alasan_batal = ''.obs;
  RxString status = ''.obs;
  final String? reason;
  final String? paymentMethod;
  final String? orderMethod;
  RxBool isRatingDone;
  final List<VarianList>? selectedVarian;
  List<ToppingList>? selectedToppings;

  Order({
    required this.id,
    required this.totalprice,
    required this.menus,
    required this.status,
    required this.orderMethod,
    required this.paid,
    // this.vouchers,
    required this.catatan,
    required this.alasan_batal,
    this.reason,
    this.paymentMethod,
    this.selectedVarian,
    this.selectedToppings,
    bool isRatingDone = false,
  }) : isRatingDone = isRatingDone.obs;

  @override
  String toString() {
    return 'OrderList(orderID: $id, menus: $menus, status: $status, orderMethod: $orderMethod, paid: $paid, catatan: $catatan, alasan_batal: $alasan_batal, reason: $reason,paymentMethod: $paymentMethod,selectedVarian: $selectedVarian,selectedToppings: $selectedToppings,isRatingDone: $isRatingDone)';
  }

}



// Objek Order pertama
List<Order> orderList = [
  Order(
      id: 001,
      menus: [
        MenuList(
          menuId: 1,
          nameMenu: "Mendoan",
          price: 1000,
          quantity: 1,
          image: 'https://warmindo.pradiptaahmad.tech/menu/1717137513.jpg',
          category: 'Snack', description: 'Mendoan adalah tempe tipis yang dibalut adonan tepung berbumbu dan digoreng sebentar sehingga bagian luarnya renyah sementara dalamnya tetap lembut.',
        ),
        MenuList(
          menuId: 2,
          nameMenu: "Es Teh",
          price: 3000,
          quantity: 3,
          image: 'https://warmindo.pradiptaahmad.tech/menu/1717146377.jpg',
          category: 'Minuman',
          description: 'Es teh minuman teh yang disajikan dingin dengan es batu',
        ),
        MenuList(
          menuId:4,
          nameMenu: "Ayam Serondeng",
          price: 10000,
          quantity: 1,
          image: 'https://warmindo.pradiptaahmad.tech/menu/1717146658.jpg', category: 'Makanan', description: 'Ayam serundeng merupakan menu makanan yang terbuat dari potongan ayam dengan taburan parutan kelapa dan lengkuas yang goreng. Makanan khas Indonesia ini nikmat disantap dengan nasi hangat dan sambal',
        )
      ],
      status: "Batal".obs,
      orderMethod: "Takeaway",
      paymentMethod: "OVO", paid: true, catatan: 'Serondengnya dikit aja',alasan_batal: 'Sudah dibelikan makan oleh orang tua'.obs, totalprice: 14000
  ),
  Order(
      id: 002,
      // vouchers: [
      //   voucherList.firstWhere((voucher) => voucher.id == 2, orElse: () => throw Exception('Voucher not found')),
      // ],
      menus: [
        MenuList(
          menuId:4,
          nameMenu: "Ayam Serondeng",
          price: 10000,
          quantity: 1,
          image: 'https://warmindo.pradiptaahmad.tech/menu/1717146658.jpg', category: 'Makanan', description: 'Ayam serundeng merupakan menu makanan yang terbuat dari potongan ayam dengan taburan parutan kelapa dan lengkuas yang goreng. Makanan khas Indonesia ini nikmat disantap dengan nasi hangat dan sambal',
        )
      ],
      status: "Selesai".obs,
      orderMethod: "Takeaway",
      paymentMethod: "DANA",
      paid: true, catatan: '-', alasan_batal: ''.obs, totalprice: 10000
  ),
  Order(
      id: 003,
      // vouchers: [
      //   voucherList.firstWhere((voucher) => voucher.id == 2, orElse: () => throw Exception('Voucher not found')),
      // ],
      menus: [
        MenuList(
          menuId:4,
          nameMenu: "Ayam Serondeng",
          price: 10000,
          quantity: 1,
          image: 'https://warmindo.pradiptaahmad.tech/menu/1717146658.jpg', category: 'Makanan', description: 'Ayam serundeng merupakan menu makanan yang terbuat dari potongan ayam dengan taburan parutan kelapa dan lengkuas yang goreng. Makanan khas Indonesia ini nikmat disantap dengan nasi hangat dan sambal',
        )
      ],
      status: "Menunggu Batal".obs,
      orderMethod: "Takeaway",
      paymentMethod: "DANA",
      paid: true, catatan: '-',alasan_batal: 'Sudah dibelikan makan oleh orang tua'.obs, totalprice: 10000
  ),
  Order(
      id: 004,
      // vouchers: [
      //   voucherList.firstWhere((voucher) => voucher.id == 2, orElse: () => throw Exception('Voucher not found')),
      // ],
      menus: [
        MenuList(
          menuId:4,
          nameMenu: "Ayam Serondeng",
          price: 10000,
          quantity: 1,
          image: 'https://warmindo.pradiptaahmad.tech/menu/1717146658.jpg', category: 'Makanan', description: 'Ayam serundeng merupakan menu makanan yang terbuat dari potongan ayam dengan taburan parutan kelapa dan lengkuas yang goreng. Makanan khas Indonesia ini nikmat disantap dengan nasi hangat dan sambal',
        )
      ],
      status: "Sedang Diproses".obs,
      orderMethod: "Takeaway",
      paymentMethod: "DANA",
      paid: true, catatan: 'Serondengnya banyakin', alasan_batal: ''.obs, totalprice: 10000
  ),
  Order(
      id: 005,
      // vouchers: [
      //   voucherList.firstWhere((voucher) => voucher.id == 2, orElse: () => throw Exception('Voucher not found')),
      // ],
      menus: [
        MenuList(
          menuId:4,
          nameMenu: "Ayam Serondeng",
          price: 10000,
          quantity: 1,
          image: 'https://warmindo.pradiptaahmad.tech/menu/1717146658.jpg', category: 'Makanan', description: 'Ayam serundeng merupakan menu makanan yang terbuat dari potongan ayam dengan taburan parutan kelapa dan lengkuas yang goreng. Makanan khas Indonesia ini nikmat disantap dengan nasi hangat dan sambal',
        )
      ],
      status: "Pesanan Siap".obs,
      orderMethod: "Takeaway",
      paymentMethod: "DANA",
      paid: true, catatan: '-', alasan_batal: ''.obs, totalprice: 10000
  ),
];


