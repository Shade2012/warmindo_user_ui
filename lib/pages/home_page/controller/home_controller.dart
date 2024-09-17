import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_user_ui/common/global_variables.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/pages/home_page/controller/schedule_controller.dart';
import 'package:warmindo_user_ui/pages/profile_page/controller/profile_controller.dart';
import '../view/home_detaile_page.dart';

class HomeController extends GetxController {
  late final SharedPreferences prefs;
final ScheduleController scheduleController = Get.put(ScheduleController());
  final ProfileController profileController = Get.put(ProfileController());

  RxString txtUsername = "".obs;
  RxString token = "".obs;
  RxList<MenuList> menuElement = <MenuList>[].obs;
  RxBool isLoading = true.obs;
  RxBool isConnected = true.obs;
  RxString id = ''.obs;
  @override
  void onInit() async {
    super.onInit();
    await scheduleController.fetchSchedule(true);
    await checkConnectivity();
  }
  Future<void> fetchname() async {
    try {
      isLoading.value = true; // Set loading to true before fetching data

      final response = await http.get(Uri.parse(GlobalVariables.apiDetailUser),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success']) {
          txtUsername.value = data['user']['name'];
          profileController.user_verified.value = data['user']['user_verified'];
        }
      }
    } catch (e) {
      if(Get.isSnackbarOpen != true) {
        Get.snackbar(
          'Error',
          '$e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      isLoading.value = false; // Set loading to false after data is fetched
    }
  }

  Future<void>  checkConnectivity() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      token.value = prefs.getString('token') ?? '';
      prefs.setString('token2',token.value = prefs.getString('token')?? '') ?? '';
      id.value = prefs.getString('user_id') ?? '';
    }
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      isConnected.value = result != ConnectivityResult.none;
      if (isConnected.value) {
       await fetchProduct();
       await fetchname();
      }
    });

    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;
    if (isConnected.value) {
      await fetchProduct();
      await fetchname();

    }
  }

  Future<void> fetchProduct() async {
    isLoading.value = true;
    try {

      final response = await http.get(
        Uri.parse(GlobalVariables.apiMenuUrl),
      );

      if (response.statusCode == 200) {
        final menu = menuListFromJson(response.body);
        menuElement.value = menu.where((element) => element.statusMenu == '1' && element.stock! > 1 ).toList();
      }
    } catch (e) {
      if(Get.isSnackbarOpen != true) {
        Get.snackbar(
          'Error',
          '$e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToFilteredMenu(BuildContext context, int priceThreshold) {
    final filteredMenu = menuElement.where((menu) => menu.price == priceThreshold).toList();
    Get.to(FilteredMenuPage(filteredMenu: filteredMenu, price: priceThreshold)
    );
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
  final filteredItems = menuElements.where((item) => item.category == categoryName && item.statusMenu != '0' && item.stock! >= 1).toList();

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

}
