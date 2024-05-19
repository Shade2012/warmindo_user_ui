

import 'package:get/get.dart';

import '../../../utils/themes/image_themes.dart';
import '../../voucher_page/model/voucher_model.dart';

class Order {
  final int id;
  final bool paid;
  final List<Menu> menus;
  final List<Voucher>? vouchers;
  RxString status = ''.obs;
  final String? reason;
  final String? paymentMethod;
  final String? orderMethod;
  Order({
    required this.id,
    required this.menus,
    required this.status,
    required this.orderMethod,
    required this.paid,
    this.vouchers,
    this.reason,
    this.paymentMethod,
  });
}

class Menu {
  final int id;
  final String name;
  final int price;
  final String imagePath;
  final int quantity;


  Menu({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.quantity
  });
}

// Objek Order pertama
List<Order> orderList = [
Order(
    id: 001,
    menus: [
      Menu(
        name: "Mendoan",
        price: 1000,
        quantity: 1,
        imagePath: Images.promo1,
        id: 12,
      ),
      Menu(
          name: "Es Teh",
          price: 3000,
          quantity: 3,
          imagePath: Images.promo1, id: 11
      ),
      Menu(
          id:7,
          name: "Mie Ayam Penyet",
          price: 13000,
          quantity: 1,
          imagePath: Images.promo1
      )
    ],
    status: "Batal".obs,
    orderMethod: "Takeaway",
    paymentMethod: "OVO", paid: true
),
Order(
    id: 002,
    vouchers: [
      voucherList.firstWhere((voucher) => voucher.id == 2, orElse: () => throw Exception('Voucher not found')),
    ],
    menus: [
      Menu(
          name: "Mie Ayam penyet",
          price: 13000,
          imagePath: Images.promo1,
          quantity: 1, id: 7
      )
    ],
    status: "Selesai".obs,
    orderMethod: "Takeaway",
    paymentMethod: "DANA",
    paid: true
),
Order(
    id: 003,
    vouchers: [
      voucherList.firstWhere((voucher) => voucher.id == 2, orElse: () => throw Exception('Voucher not found')),
    ],
    menus: [
      Menu(
          name: "Mie Ayam penyet",
          price: 13000,
          imagePath: Images.promo1,
          quantity: 1, id: 7
      )
    ],
    status: "Menunggu Batal".obs,
    orderMethod: "Takeaway",
    paymentMethod: "DANA",
    paid: true
),
 Order(
    id: 004,
    vouchers: [
      voucherList.firstWhere((voucher) => voucher.id == 2, orElse: () => throw Exception('Voucher not found')),
    ],
    menus: [
      Menu(
          name: "Mie Ayam penyet",
          price: 13000,
          imagePath: Images.promo1,
          quantity: 1, id: 7
      )
    ],
    status: "In Progress".obs,
    orderMethod: "Takeaway",
    paymentMethod: "DANA",
     paid: true
),
 Order(
    id: 005,
    vouchers: [
      voucherList.firstWhere((voucher) => voucher.id == 2, orElse: () => throw Exception('Voucher not found')),
    ],
    menus: [
      Menu(
          name: "Mie Ayam penyet",
          price: 13000,
          imagePath: Images.promo1,
          quantity: 1, id: 7
      )
    ],
    status: "Pesanan Siap".obs,
    orderMethod: "Takeaway",
    paymentMethod: "DANA",
     paid: true
),
];


