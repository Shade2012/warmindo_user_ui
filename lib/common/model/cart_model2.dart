import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:warmindo_user_ui/common/model/toppings.dart';
import 'package:warmindo_user_ui/common/model/varians.dart';

class CartItem2 {
  RxInt? cartId;
  final int productId;
  final String productName;
  final String productImage;

  final int price;
  RxInt quantity = 1.obs;
  VarianList? selectedVarian;
  List<ToppingList>? selectedToppings;

  CartItem2({
    this.cartId,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    this.selectedVarian,
    this.selectedToppings,
  });

  factory CartItem2.fromJson(Map<String, dynamic> json) {
    return CartItem2(
      cartId: (json['id'] != null) ? (json['id'] as int).obs : null,
      productId: json['menu_id'],
      productName: json['menu'] != null ? json['menu']['name_menu'] : '',
      productImage: json['menu'] != null ? json['menu']['image'] : '',
      price: _parsePrice(json['menu'] != null ? json['menu']['price'] : 0),
      quantity: _parseQuantity(json['quantity']).obs,
      selectedVarian: json['variant'] != null ? VarianList.fromJson(json['variant']) : null,
      selectedToppings: json['toppings'] != null
          ? (json['toppings'] as List<dynamic>)
          .map((item) => ToppingList.fromJson(item))
          .toList()
          : [], // Handle null case by assigning an empty list
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': cartId?.value, // Convert RxInt to int
      'menu_id': productId,
      'quantity': quantity.value.toString(),
      'menu': {
        'id': productId,
        'name_menu': productName,
        'image': productImage,
        'price': price.toString(),
      },
      'variant': selectedVarian?.toJson(),
      'toppings': selectedToppings?.map((topping) => topping.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'CartItem2(cartId: ${cartId?.value}, productId: $productId, productName: $productName, productImage: $productImage, price: $price, quantity: ${quantity.value}, selectedVarian: $selectedVarian, selectedToppings: $selectedToppings)';
  }

  static int _parsePrice(dynamic price) {
    if (price is int) {
      return price;
    } else if (price is String) {
      return int.tryParse(price) ?? 0;
    } else {
      return 0;
    }
  }

  static int _parseQuantity(dynamic quantity) {
    if (quantity is int) {
      return quantity;
    } else if (quantity is String) {
      return int.tryParse(quantity) ?? 0;
    } else {
      return 0;
    }
  }
}



