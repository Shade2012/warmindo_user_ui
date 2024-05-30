import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../common/model/menu_list_API_model.dart';

class GuestMenuController extends GetxController {
  final TextEditingController search = TextEditingController();
  RxList<MenuList> menuElement = <MenuList>[].obs;
  RxList<MenuList> searchResults = <MenuList>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProduct();
  }
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

}
