import 'dart:convert';
import 'package:get/get.dart';

// Function to parse JSON into a list of ToppingList objects
List<ToppingList> toppingListFromJson(String str) {
  final jsonData = json.decode(str);
  return List<ToppingList>.from(jsonData["data"].map((item) => ToppingList.fromJson(item)));
}

// Function to convert Data object to JSON string
String toppingToJson(Data data) => json.encode(data.toJson());

class Data {
  final List<ToppingList> topping;

  Data({
    required this.topping,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    topping: List<ToppingList>.from(json["data"].map((x) => ToppingList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(topping.map((x) => x.toJson())),
  };
}

// ToppingList model
class ToppingList {
  final int toppingID;
  final String nameTopping;
  final int priceTopping;
  final String? stockTopping;
  final String? statusTopping;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Menu> menus;  // List of associated menus
  var isSelected = false.obs;

  ToppingList({
    required this.toppingID,
    required this.nameTopping,
    required this.priceTopping,
    this.stockTopping,
    this.statusTopping,
    this.createdAt,
    this.updatedAt,
    required this.menus,  // Initialize menus in constructor
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ToppingList && other.toppingID == toppingID;
  }

  @override
  int get hashCode => toppingID.hashCode;

  // Factory constructor to parse JSON data
  factory ToppingList.fromJson(Map<String, dynamic> json) => ToppingList(
    toppingID: json["id"] ?? 0,
    nameTopping: json["name_topping"] ?? '',
    priceTopping: json["price"] ?? 0,
    stockTopping: json["stock"]?.toString() ?? '',
    statusTopping: json['status_topping'] ?? '1',
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
    menus: json["menus"] != null
        ? List<Menu>.from(json["menus"].map((x) => Menu.fromJson(x)))
        : [], // Handle null case by assigning an empty list
  );


  // Method to convert ToppingList object to JSON
  Map<String, dynamic> toJson() => {
    "id": toppingID,
    "name_topping": nameTopping,
    "price": priceTopping,
    "status_topping": statusTopping,
    "stock": stockTopping.toString(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "menus": List<dynamic>.from(menus.map((x) => x.toJson())),  // Convert menus to JSON
  };

  @override
  String toString() {
    return 'ToppingList(id: $toppingID, name_topping: $nameTopping, status_topping: $statusTopping, price: $priceTopping, stock: $stockTopping, menus: $menus)';
  }
}

// Menu model to represent the associated menus for a topping
class Menu {
  final int menuID;
  final String menuName;

  Menu({
    required this.menuID,
    required this.menuName,
  });

  // Factory constructor to parse JSON data
  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    menuID: json["menu_id"],
    menuName: json["menu_name"],
  );

  // Method to convert Menu object to JSON
  Map<String, dynamic> toJson() => {
    "menu_id": menuID,
    "menu_name": menuName,
  };

  @override
  String toString() {
    return 'Menu(menuID: $menuID, menuName: $menuName)';
  }
}
