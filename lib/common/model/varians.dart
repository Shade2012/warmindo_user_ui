import 'dart:convert';

import 'package:get/get.dart';

List<VarianList> varianListFromJson(String str) {
  final jsonData = json.decode(str);
  return List<VarianList>.from(jsonData["data"].map((item) => VarianList.fromJson(item)));
}

class Data {
  final List<VarianList> varian;

  Data({
    required this.varian,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    varian: List<VarianList>.from(json["data"].map((x) => VarianList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(varian.map((x) => x.toJson())),
  };
}

class VarianList {
  final int varianID;
  final String nameVarian;
  final String category;
  final String stockVarian;
  final String? statusVarian;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  var isSelected = false.obs;

  VarianList({
    required this.varianID,
    required this.nameVarian,
    required this.category,
    required this.stockVarian,
    bool? isSelected,
    this.statusVarian,
    this.createdAt,
    this.updatedAt,
  });
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VarianList && other.varianID == varianID;
  }

  @override
  int get hashCode => varianID.hashCode;

  factory VarianList.fromJson(Map<String, dynamic> json) => VarianList(
    varianID: json["id"] ?? 0, // Changed to match API field
    nameVarian: json["name_varian"] ?? '',
    category: json["category"] ?? '',
    stockVarian: json["stock_varian"] ?? '', // Convert string to int
    statusVarian: json["status_variant"]?? '0',
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": varianID, // Changed to match API field
    "name_varian": nameVarian,
    "category": category,
    "stock_varian": stockVarian.toString(), // Convert int to string
    "status_variant":statusVarian,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  @override
  String toString() {
    return 'VarianList(id: $varianID, name_varian: $nameVarian, category: $category, status_variant: $statusVarian, stock_varian: $stockVarian)';
  }
}
