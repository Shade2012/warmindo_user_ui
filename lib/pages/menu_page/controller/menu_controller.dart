import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../common/global_variables.dart';
import '../../../common/model/menu_list_API_model.dart';
import '../../../common/model/search_model.dart';


class MenuPageController extends GetxController {
  final TextEditingController search = TextEditingController();
  RxList<MenuList> menuElement = <MenuList>[].obs;
  RxList<MenuList> menuWithDisable = <MenuList>[].obs;
  RxList<MenuList> searchResults = <MenuList>[].obs;
  RxBool isLoading = true.obs;
  String lastQuery = '';
  RxBool isConnected = true.obs;
  RxString searchObx = ''.obs;
  late Timer _debounce = Timer(Duration.zero, () { });


  @override
  void onInit() async {
    super.onInit();

    fetchProduct();
    checkConnectivity();
    search.addListener(() {
      searchObx.value = search.text;
    });
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

  Future<void> fetchProduct() async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse(GlobalVariables.apiMenuUrl),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final menu = menuListFromJson(response.body);
        menuWithDisable.value = menu;
        menuElement.value = menu.where((element) => element.statusMenu == '1').toList();

      }
    } catch (e) {
      Get.snackbar('Error', '$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchFilter(String query)  async {
    if (_debounce.isActive) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final response = await http.get(
          Uri.parse(
              '${GlobalVariables.apiSearchUrl}$query'),
        ).timeout(const Duration(seconds: 5));

        if (response.statusCode == 200) {
          if (query == '') {
            Future.delayed(const Duration(seconds: 3),(){
            searchResults.clear();
            });
          } else {
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
      } catch (e) {
        Get.snackbar('Error', '$e');
      }
    });
    }

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
  // Future<void> refreshSearchResults() async {
  //   if (lastQuery.isNotEmpty) {
  //     await searchFilter(lastQuery);
  //   }
  // }
  @override
  void onClose() {
    // TODO: implement onClose
    _debounce.cancel();  // Cancel the debouncer
    search.dispose();     // Dispose of the search controller
    super.onClose();
  }
}

