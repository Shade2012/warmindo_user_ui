import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:warmindo_user_ui/common/model/toppings.dart';
import 'package:warmindo_user_ui/common/model/varians.dart';

import 'menu_list_API_model.dart';

class Order2 {
  final int id;
  final String totalprice;
  final List<MenuList> orderDetails;
  String catatan;
  RxString? alasan_batal = ''.obs;
  RxString? cancelMethod = ''.obs;
  RxString? noRekening = ''.obs;
  RxString status = ''.obs;
  final String? paymentMethod;
  final String? orderMethod;
  RxBool isRatingDone;

  Order2({
    required this.id,
    required this.totalprice,
    required this.orderDetails,
    required this.status,
    required this.orderMethod,
    required this.catatan,
    this.alasan_batal,
    this.paymentMethod,
    this.cancelMethod,
    this.noRekening,
    bool isRatingDone = false,
  }) : isRatingDone = isRatingDone.obs;

  factory Order2.fromJson(Map<String, dynamic> json) {
    return Order2(
      id: json['id'],
      totalprice: json['price_order'],
      cancelMethod: RxString(json['cancel_method']?? ''),
      alasan_batal: RxString(json['reason_cancel']?? '') ,
      noRekening: RxString(json['no_rekening']?? '') ,
      paymentMethod: json['payment_method'] ?? '-',
      orderMethod: json['order_method'] ?? '-',
      orderDetails: (json['orderDetails'] as List)
          .map((item) => MenuList.fromOrderDetailJson(item))
          .toList() ?? [],
      status: RxString(json['status']),
      catatan: json['note'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price_order': totalprice,
      'orderDetails': orderDetails.map((item) => item.toJson()).toList(),
      'status': status.value,
      'note': catatan,
    };
  }

  Map<String, dynamic> toCartJson() {
    return {
      "datas": orderDetails.map((menu) {
        return {
          "quantity": menu.quantity,
          "menu_id": menu.menuId,
          "variant_id": menu.variantId ?? '',
          "toppings": menu.toppings?.map((topping) {
            return {
              "topping_id": topping.toppingID,
              "quantity": menu.quantity, // Assuming ToppingList has a quantity field
            };
          }).toList(),
        };
      }).toList(),
    };
  }
}
class MenuList {
  final int menuId;
  final int orderDetailId;
  final String? statusMenu;
  final String image;
  final String nameMenu;
  final int price;
  final String category;
  final String? stock;
   RxDouble ratings;
  final String description;
  final String? secondCategory;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? variantId;
  final List<ToppingList>? toppings;
  final VarianList? selectedVarian;
  int quantity;

  MenuList({
    required this.orderDetailId,
    required this.menuId,
    required this.image,
    required this.nameMenu,
    required this.price,
    required this.category,
    this.stock,
    required this.ratings,
    this.statusMenu,
    required this.description,
    this.createdAt,
    this.updatedAt,
    this.secondCategory,
    this.quantity = 1,
    this.variantId,
    this.toppings = const [],
    this.selectedVarian,
  });

  factory MenuList.fromOrderDetailJson(Map<String, dynamic> json) {
    return MenuList(
      orderDetailId: json['id'],
      menuId: json['menu']['id'],
      image: json['menu']['image'],
      nameMenu: json['menu']['name_menu'],
      price: int.parse(json['menu']['price']),
      category: json['menu']['category'],
      stock: json['menu']['stock'],
      statusMenu: json['menu']['status_menu'],
      // ratings: json['menu']['average_rating'] != null ? double.parse(json['menu']['average_rating']) : null,
      description: json['menu']['description'],
      secondCategory: json['menu']['second_category'],
      createdAt: DateTime.parse(json['menu']['created_at']),
      updatedAt: DateTime.parse(json['menu']['updated_at']),
      variantId: json['variant_id'] ?? null,
        selectedVarian: json['variant'] != null ? VarianList.fromJson(json['variant']) : null,
      toppings: (json['toppings'] as List)
          .map((topping) => ToppingList.fromJson(topping))
          .toList(),
      quantity: json['quantity'],ratings: json['user_rating'] != null ? double.parse(json['user_rating']).obs : 0.0.obs,

    );
  }

  Map<String, dynamic> toJson() => {
    "menuID": menuId,
    "image": image,
    "name_menu": nameMenu,
    "price": price.toString(),
    "category": category,
    "status_menu": statusMenu,
    "stock": stock.toString(),
    "ratings": ratings.toString(),
    "description": description,
    "second_category": secondCategory,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

