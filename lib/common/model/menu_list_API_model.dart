// To parse this JSON data, do
//
//     final menu = menuFromJson(jsonString);

import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:warmindo_user_ui/common/model/toppings.dart';

List<MenuList> menuListFromJson(String str) {
  final jsonData = json.decode(str);
  return List<MenuList>.from(jsonData.map((item) => MenuList.fromJson(item)));
}
List<MenuList> foodMenuListFromJson(String str) {
  final jsonData = json.decode(str);
  return List<MenuList>.from(jsonData.map((item) => MenuList.fromJson(item)));
}
class Data {
  final bool success;
  final String message;
  final List<MenuList> menu;

  Data({
    required this.success,
    required this.message,
    required this.menu,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    success: json["success"],
    message: json["message"],
    menu: List<MenuList>.from(json["menu"].map((x) => MenuList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
  };
}

class MenuList {
  final int menuId;
  final String image;
  final String nameMenu;
  final int price;
  final String category;
  final RxInt? stock;
  late double? rating;
  final String description;
  final String? second_category;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? statusMenu;
  final int? variantId;
  final List<ToppingList>? toppings;
  int quantity;

  MenuList(
      {
    required  this.menuId,
        required  this.statusMenu,
    required  this.image,
    required this.nameMenu,
    required  this.price,
    required this.category,
      this.stock,
    this.rating,
   required this.description,
    this.createdAt,
    this.updatedAt,
        this.second_category,
        this.quantity = 1,
        this.variantId,
        this.toppings = const [],
  });

  factory MenuList.fromJson(Map<String, dynamic> json) => MenuList(
    menuId: json["id"],
    image: json["image"],
    nameMenu: json["name_menu"],
    price: int.tryParse(json["price"] ?? '0') ?? 0, // Safer parsing
    category: json["category"],
    stock: (int.tryParse(json["stock"] ?? '0') ?? 0).obs, // Safer parsing
      rating: double.tryParse(json["rating"] ?? '0') ?? 0.0, // Safer parsing
    description: json["description"],
    second_category: json["second_category"],
    statusMenu: json['status_menu'],
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
  );


  Map<String, dynamic> toJson() => {
    "menuID": menuId,
    "image": image,
    "name_menu": nameMenu,
    "price": price.toString(),
    "category": category,
    "stock": stock.toString(),
    "rating": rating.toString(),
    "description": description,
    "second_category": second_category,
    "status_menu": statusMenu,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  @override
  String toString() {
    return 'MenuList(menuId: $menuId, nameMenu: $nameMenu, price: $price, category: $category, stock: $stock,second_category: $second_category , rating: $rating, status_menu: $statusMenu)';
  }
}




