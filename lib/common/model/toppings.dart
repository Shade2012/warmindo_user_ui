import 'dart:convert';

import 'package:get/get.dart';

List<ToppingList> toppingListFromJson(String str) {
  final jsonData = json.decode(str);
  return List<ToppingList>.from(jsonData["data"].map((item) => ToppingList.fromJson(item)));
}

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

class ToppingList {
  final int toppingID;
  final String nameTopping;
  final int priceTopping;
  final String? stockTopping;
  final String? statusTopping;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  var isSelected = false.obs;

  ToppingList({
    required this.toppingID,
    required this.nameTopping,
    required this.priceTopping,
    this.stockTopping,
    this.statusTopping,
    bool? isSelected,
    this.createdAt,
    this.updatedAt,
  });
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ToppingList && other.toppingID == toppingID;
  }

  @override
  int get hashCode => toppingID.hashCode;

  factory ToppingList.fromJson(Map<String, dynamic> json) => ToppingList(
    toppingID: json["id"]?? '',
    nameTopping: json["name_topping"] ?? '',
    priceTopping: json["price"] ?? '',
    stockTopping: json["stock_topping"] ?? '',
    statusTopping: json['status_topping'] ?? '1',
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": toppingID,
    "name_topping": nameTopping,
    "price": priceTopping,
    "status_topping":statusTopping,
    "stock_topping": stockTopping.toString(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  @override
  String toString() {
    return 'ToppingList(id: $toppingID, name_topping: $nameTopping, status_topping: $statusTopping, price: $priceTopping, stock_topping: $stockTopping)';
  }
}
