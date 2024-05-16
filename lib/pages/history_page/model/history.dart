

import '../../../utils/themes/image_themes.dart';
import '../../voucher_page/model/voucher_model.dart';

class Order {
  final int id;
  final List<Menu> menus;
  final List<Voucher>? vouchers;
  final String status;
  final String? reason;
  final String? paymentMethod;
  final String? orderMethod;
  Order({
    required this.id,
    required this.menus,
    required this.status,
    required this.orderMethod,
    this.vouchers,
    this.reason,
    this.paymentMethod,
  });
}

class Menu {
  final String name;
  final int price;
  final String imagePath;
  final int quantity;

  Menu({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.quantity
  });
}

// Objek Order pertama


Order order001 = Order(
    id: 001,
    menus: [
      Menu(
          name: "Mendoan",
          price: 4000,
          quantity: 1,
          imagePath: Images.promo1
      ),
      Menu(
          name: "Es Teh",
          price: 3000,
          quantity: 3,
          imagePath: Images.promo1
      )
    ],
    status: "Batal",
    orderMethod: "Takeaway",
    paymentMethod: "OVO"
);
Order order002 = Order(
    id: 002,
    menus: [
      Menu(
          name: "Mie Ayam Geprek",
          price: 14000,
          imagePath: Images.promo1,
          quantity: 1
      )
    ],
    status: "Selesai",
    orderMethod: "Takeaway",
    paymentMethod: "DANA"
);
