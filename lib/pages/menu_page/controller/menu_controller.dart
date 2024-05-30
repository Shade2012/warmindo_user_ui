import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_user_ui/common/model/menu_model.dart';
import 'dart:convert';

import '../../../common/model/menu_list_API_model.dart';
import '../../../common/model/search_model.dart';


class MenuPageController extends GetxController {
  final TextEditingController search = TextEditingController();
  RxList<MenuList> menuElement = <MenuList>[].obs;
  RxList<MenuList> searchResults = <MenuList>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProduct();
  }

  void fetchProduct() async {
    try {
      final response = await http.get(
        Uri.parse('https://warmindo.pradiptaahmad.tech/api/menus/'),
      );

      if (response.statusCode == 200) {
        menuElement.value = menuListFromJson(response.body);
        print("Fetched menu list: ${menuElement.length} items");
        isLoading.value = false; // Set loading to false after data is fetched
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  // void searchMenu(String query) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(
  //           'https://warmindo.pradiptaahmad.tech/api/menus/search?q=$query'),
  //     ).timeout(Duration(seconds: 5));
  //
  //     if (response.statusCode == 200) {
  //       if(query == ''){
  //          searchResults.clear();
  //         searchResults.refresh();
  //       }else{
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
  //
  //       }
  //
  //     } else {
  //       print('Error: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  void searchFilter(String enteredKeyword) {
    if (enteredKeyword == '') {
      searchResults.clear();
    } else {
      enteredKeyword = enteredKeyword.toLowerCase();
      searchResults.assignAll(menuElement.where((product) {
        return product.nameMenu.toLowerCase().contains(enteredKeyword);
      }).toList());
    }
  }

}
