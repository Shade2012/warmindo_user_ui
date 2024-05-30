import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_rx/get_rx.dart';
import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/common/global_variables.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import '../view/home_detaile_page.dart';

class HomeController extends GetxController {

  RxList<MenuList> menuElement = <MenuList>[].obs;

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();

    fetchProduct();
  }

  void fetchProduct() async {
    try {
      final response = await http.get(
        Uri.parse(GlobalVariables.apiMenuUrl),
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


  void navigateToFilteredMenu(BuildContext context, int priceThreshold) {
    final filteredMenu = menuElement.where((menu) => menu.price == priceThreshold).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilteredMenuPage(filteredMenu: filteredMenu, price: priceThreshold),
      ),
    );
  }
}


