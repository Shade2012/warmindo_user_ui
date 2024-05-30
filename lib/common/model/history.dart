

import 'package:get/get.dart';
import 'package:warmindo_user_ui/common/model/menu_model.dart';

import '../../utils/themes/image_themes.dart';
import 'voucher_model.dart';

class Order {
  final int id;
  final bool paid;
  final List<Menu> menus;
  final List<Voucher>? vouchers;
  RxString status = ''.obs;
  final String? reason;
  final String? paymentMethod;
  final String? orderMethod;
  RxBool isRatingDone;
  Order({
    required this.id,
    required this.menus,
    required this.status,
    required this.orderMethod,
    required this.paid,
    this.vouchers,
    this.reason,
    this.paymentMethod,
    bool isRatingDone = false, // Initialize as regular boolean value
  }) : isRatingDone = isRatingDone.obs;
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
        id: 12, category: 'makanan', description: 'tempe',ratings: [4.7]
      ),
      Menu(
          name: "Es Teh",
          price: 3000,
          quantity: 3,
          imagePath: Images.promo1, id: 11, category: '', description: '',ratings: [4.0]
      ),
      Menu(
          id:7,
          name: "Mie Ayam Penyet",
          price: 13000,
          quantity: 1,
          imagePath: Images.promo1, category: '', description: '',ratings: [4.6]
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
          name: "Mie Ayam Penyet",
          price: 13000,
          imagePath: Images.promo1,
          quantity: 1, id: 7, category: '', description: '',ratings: [4.6]
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
          name: "Mie Ayam Penyet",
          price: 13000,
          imagePath: Images.promo1,
          quantity: 1, id: 7,
          category: '', description: '',ratings: [4.6]
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
          name: "Mie Ayam Penyet",
          price: 13000,
          imagePath: Images.promo1,
          quantity: 1, id: 7,
          category: '', description: '',ratings: [4.6]
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
          name: "Mie Ayam Penyet",
          price: 13000,
          imagePath: Images.promo1,
          quantity: 1, id: 7,
          category: '', description: '',ratings: [4.6]
      )
    ],
    status: "Pesanan Siap".obs,
    orderMethod: "Takeaway",
    paymentMethod: "DANA",
     paid: true
),
];


