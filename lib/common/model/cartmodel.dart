// import 'package:get/get.dart';
//
// import '../../utils/themes/image_themes.dart';
//
// class CartItem {
//   final int productId;
//   final String productName;
//   final String productImage;
//   final int price;
//   late RxInt quantity = 0.obs;
//
//   CartItem({
//     required this.productId,
//     required this.productName,
//     required this.productImage,
//     required this.price,
//     required this.quantity,
//   });
// }

import 'package:get/get.dart';

class CartItem {
  final int? cartId;
  final int productId;
  final String productName;
  final String productImage;
  final double price;
  RxInt quantity;

  CartItem({
     this.cartId,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      cartId: json['cart_id'] ?? 0,
      productId: json['menu']['menuID'],
      productName: json['menu']['name_menu'],
      productImage: json['menu']['image'],
      price: double.parse(json['menu']['price']),
      quantity: int.parse(json['quantity']).obs,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cart_id': cartId,
      'menu': {
        'menuID': productId,
        'name_menu': productName,
        'image': productImage,
        'price': price.toString(),
      },
      'quantity': quantity.value.toString(),
    };
  }
}

