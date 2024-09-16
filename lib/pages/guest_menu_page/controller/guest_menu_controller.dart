import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../common/global_variables.dart';
import '../../../common/model/menu_list_API_model.dart';
import '../../../common/model/search_model.dart';


class GuestMenuController extends GetxController {
  final TextEditingController search = TextEditingController();
  RxList<MenuList> menuElement = <MenuList>[].obs;
  RxList<MenuList> searchResults = <MenuList>[].obs;
  RxBool isLoading = true.obs;
  String lastQuery = '';  // Store the last query
  RxBool isConnected = true.obs;
  RxString searchObx = ''.obs;
  RxInt statusCode = 0.obs;
  late Timer _debounce = Timer(Duration.zero, () { });
  @override
  void onInit() async {
    super.onInit();
    fetchProduct();
    checkConnectivity();
    search.addListener((){
      searchObx.value = search.text;
      // searchFilter(search.text);
    });
  }

  Future<void> fetchProduct() async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse(GlobalVariables.apiMenuUrl),
      );

      if (response.statusCode == 200) {
        menuElement.value = menuListFromJson(response.body);
      } else {
        Get.snackbar('Error', response.body);
      }
    } catch (e) {
      Get.snackbar('Error', '$e');

    } finally {
      isLoading.value = false;
    }
  }
  void checkConnectivity() async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isConnected.value = result != ConnectivityResult.none;
      if (isConnected.value) {
        fetchProduct();
      }
    });

    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;
    if (isConnected.value) {
      fetchProduct();
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
  // Future<void> searchFilter(String enteredKeyword) async {
  //   if (enteredKeyword == '') {
  //     searchResults.clear();
  //   } else {
  //     enteredKeyword = enteredKeyword.toLowerCase();
  //     searchResults.assignAll(menuElement.where((product) {
  //       return product.nameMenu.toLowerCase().contains(enteredKeyword);
  //     }).toList());
  //   }
  // }
  Future<void> searchFilter(String query)  async {
    if (_debounce.isActive) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final response = await http.get(
          Uri.parse(
              '${GlobalVariables.apiSearchUrl}$query'),
        ).timeout(const Duration(seconds: 5));

        if (response.statusCode == 200) {
        {
            SearchResult searchResult = SearchResult.fromJson(
                json.decode(response.body));
            searchResults.value = searchResult.data.map((searchList) =>
                MenuList(
                  menuId: searchList.menuId,
                  image: searchList.image,
                  nameMenu: searchList.nameMenu,
                  price: searchList.price.toInt(),
                  category: searchList.category,
                  stock: searchList.stock.obs,
                  rating: searchList.ratings,
                  description: searchList.description,
                  createdAt: searchList.createdAt,
                  updatedAt: searchList.updatedAt,
                  statusMenu: searchList.statusMenu,
                )).toList();
          }
        } else {
          if(response.statusCode == 404){
            searchResults.clear();
          }
        }
        statusCode.value = response.statusCode;
      } catch (e) {
        Get.snackbar('Error', '$e');
      }
    });
  }
  // Future<void> refreshSearchResults() async {
  //   if (lastQuery.isNotEmpty) {
  //     await searchFilter(lastQuery);
  //   }
  // }
}

