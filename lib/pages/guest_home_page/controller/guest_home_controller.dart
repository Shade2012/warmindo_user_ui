import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_user_ui/pages/guest_home_page/view/guest_home_detail_page.dart';
import '../../../common/model/menu_list_API_model.dart';
import '../../../common/model/menu_model.dart';

class GuestHomeController extends GetxController {
  static const String baseUrl = 'https://warmindo.pradiptaahmad.tech/api/menus';
  RxList<MenuList> menuElement = <MenuList>[].obs;
  RxBool isLoading = true.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProduct();
  }
  void fetchProduct() async {
    try {
      final response = await http.get(
        Uri.parse('https://warmindo.pradiptaahmad.tech/api/menus'),
      ).timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        menuElement.value = menuListFromJson(response.body);
        isLoading.value = false;
        print("Fetched menu list: ${menuElement.length} items");
        // You can call the button function here if you want to print the menuList
        // button();
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
        builder: (context) => GuestFilteredMenuPage(filteredMenu: filteredMenu,price: priceThreshold),
      ),
    );
  }
}
