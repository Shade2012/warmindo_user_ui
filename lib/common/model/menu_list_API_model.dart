// To parse this JSON data, do
//
//     final menu = menuFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<MenuList> menuListFromJson(String str) {
  final jsonData = json.decode(str);
  return List<MenuList>.from(jsonData["data"]["menu"].map((item) => MenuList.fromJson(item)));
}

String menuToJson(Menu data) => json.encode(data.toJson());

class Menu {
  final Data data;

  Menu({
    required this.data,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
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
  final double price;
  final String category;
  final int? stock;
  final double? ratings;
  final String description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  int quantity;

  MenuList({
    required  this.menuId,
    required  this.image,
    required this.nameMenu,
    required  this.price,
    required this.category,
      this.stock,
    this.ratings,
   required this.description,
    this.createdAt,
    this.updatedAt,
    this.quantity = 1

  });

  factory MenuList.fromJson(Map<String, dynamic> json) => MenuList(
    menuId: json["menuID"],
    image: json["image"],
    nameMenu: json["name_menu"],
    price: double.parse(json["price"]), // Parsing string to double
    category: json["category"],
    stock: int.parse(json["stock"]), // Parsing string to int
    ratings: double.parse(json["ratings"]), // Parsing string to double
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "menuID": menuId,
    "image": image,
    "name_menu": nameMenu,
    "price": price.toString(),
    "category": category,
    "stock": stock.toString(),
    "ratings": ratings.toString(),
    "description": description,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  @override
  String toString() {
    return 'MenuList(menuId: $menuId, nameMenu: $nameMenu, price: $price, category: $category, stock: $stock, ratings: $ratings)';
  }
}




