import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_user_ui/pages/guest_home_page/view/guest_home_detail_page.dart';
import '../../../common/model/menu_list_API_model.dart';
import '../../home_page/controller/schedule_controller.dart';

class GuestHomeController extends GetxController {
  final ScheduleController scheduleController = Get.put(ScheduleController());
  static const String baseUrl = 'https://warmindo.pradiptaahmad.tech/api/menus';
  RxList<MenuList> menuElement = <MenuList>[].obs;
  RxBool isLoading = true.obs;
  RxBool isConnected = true.obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await scheduleController.fetchSchedule();
    await checkConnectivity();
  }
  Future<void>  checkConnectivity() async {
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
  MenuList getHighestRatingMenu(List<MenuList> menuElements, int categoryId) {
    final categoryMap = {
      1: 'Makanan',
      2: 'Minuman',
      3: 'Snack',
    };
    final categoryName = categoryMap[categoryId];
    if (categoryName == null) {
      throw ArgumentError('Invalid category ID');
    }
    final filteredItems = menuElements.where((item) => item.category == categoryName && item.statusMenu != '0').toList();

    if (filteredItems.isEmpty) {
      return MenuList(
        menuId: 0,
        image: 'default_image.png',
        nameMenu: 'No items found',
        price: 0,
        category: categoryName,
        description: 'No description available', statusMenu: '1',
      );
    }
    filteredItems.sort((a, b) => b.rating?.compareTo(a.rating ?? 0) ?? 0);

    return filteredItems.first;
  }
  Future<void> fetchProduct() async {
    try {
      final response = await http.get(
        Uri.parse('https://warmindo.pradiptaahmad.tech/api/menus'),
      ).timeout(const Duration(seconds: 5));

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
    Get.to(GuestFilteredMenuPage(filteredMenu: filteredMenu, price: priceThreshold)
    );
  }
}
