import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_user_ui/common/model/menu_model.dart';
import 'dart:convert';

import '../../../common/global_variables.dart';
import '../../../common/model/menu_list_API_model.dart';
import '../../../common/model/search_model.dart';


class MenuPageController extends GetxController {
  var search = TextEditingController().obs;
  RxList<MenuList> menuElement = <MenuList>[].obs;
  RxList<MenuList> searchResults = <MenuList>[].obs;
  RxBool isLoading = true.obs;
  String lastQuery = '';  // Store the last query

  @override
  void onInit() {
    super.onInit();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse(GlobalVariables.apiMenuUrl),
      );

      if (response.statusCode == 200) {
        menuElement.value = menuListFromJson(response.body);
        print("Fetched menu list: ${menuElement.length} items");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> searchFilter(String query) async {
  //   lastQuery = query;  // Update last query
  //   try {
  //     final response = await http.get(
  //       Uri.parse('https://warmindo.pradiptaahmad.tech/api/menus/search?q=$query'),
  //     ).timeout(Duration(seconds: 5));
  //
  //     if (response.statusCode == 200) {
  //       if (query == '') {
  //         searchResults.clear();
  //       } else {
  //         SearchResult searchResult = SearchResult.fromJson(json.decode(response.body));
  //         searchResults.value = searchResult.data.map((searchList) => MenuList(
  //           menuId: searchList.menuId,
  //           image: searchList.image,
  //           nameMenu: searchList.nameMenu,
  //           price: searchList.price,
  //           category: searchList.category,
  //           stock: searchList.stock,
  //           ratings: searchList.ratings,
  //           description: searchList.description,
  //           createdAt: searchList.createdAt,
  //           updatedAt: searchList.updatedAt,
  //         )).toList();
  //       }
  //     } else {
  //       print('Error: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  Future<void> searchFilter(String enteredKeyword) async {
    if (enteredKeyword == '') {
      searchResults.clear();
    } else {
      enteredKeyword = enteredKeyword.toLowerCase();
      searchResults.assignAll(menuElement.where((product) {
        return product.nameMenu.toLowerCase().contains(enteredKeyword);
      }).toList());
    }
  }
  Future<void> refreshSearchResults() async {
    if (lastQuery.isNotEmpty) {
      await searchFilter(lastQuery);
    }
  }
}

