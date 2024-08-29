import 'dart:convert';

class SearchResult {
  final bool success;
  final String message;
  final List<SearchList> data;

  SearchResult({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      success: json['success'],
      message: json['message'],
      data: List<SearchList>.from(json['data'].map((x) => SearchList.fromJson(x))),
    );
  }
}

class SearchList {
  final int menuId;
  final String image;
  final String nameMenu;
  final double price;
  final String category;
  final int stock;
  final double ratings;
  final String description;
  final String? statusMenu;
  final DateTime createdAt;
  final DateTime updatedAt;

  SearchList({
    this.statusMenu,
    required this.menuId,
    required this.image,
    required this.nameMenu,
    required this.price,
    required this.category,
    required this.stock,
    required this.ratings,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SearchList.fromJson(Map<String, dynamic> json) {
    return SearchList(
      menuId: json["id"],
      image: json["image"],
      nameMenu: json["name_menu"],
      price: double.parse(json["price"]),
      category: json["category"],
      stock: int.parse(json["stock"]),
      ratings: double.parse(json["rating"]),
      description: json["description"],
      statusMenu: json['status_menu'],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }
}
