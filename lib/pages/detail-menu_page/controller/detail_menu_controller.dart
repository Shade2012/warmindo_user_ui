import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_user_ui/common/model/varians.dart';
import '../../../common/global_variables.dart';

import '../../../common/model/toppings.dart';

class DetailMenuController extends GetxController {
  RxList<MenuList> menu = <MenuList>[].obs;
  RxBool isConnected = true.obs;
  RxBool isLoading = true.obs;
  RxList<ToppingList> toppingList = <ToppingList>[].obs;
  RxList<VarianList> varianList = <VarianList>[].obs;
  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
  }

  Future<void> fetchProduct(int menuId) async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse(GlobalVariables.apiMenuUrl),
      );

      if (response.statusCode == 200) {
        var fetchedMenu = menuListFromJson(response.body);
        // Filter the menu based on the provided menuId
        menu.value = fetchedMenu.where((item) => item.menuId == menuId).toList();
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
  Future<void> fetchTopping () async{
    isLoading.value = true;
    try {
      final response = await http.get(
          Uri.parse(GlobalVariables.apiTopping),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }
      );

      if (response.statusCode == 200) {
        toppingList.value = toppingListFromJson(response.body);
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
  Future<void> fetchVarian () async{
    isLoading.value = true;
    try {
      final response = await http.get(
          Uri.parse(GlobalVariables.apiVarian),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }
      );

      if (response.statusCode == 200) {
        varianList.value = varianListFromJson(response.body);
        final data = jsonDecode(response.body);
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
  void checkConnectivity() async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      isConnected.value = result != ConnectivityResult.none;
      if (isConnected.value) {
        // fetchProduct();
        await fetchTopping();
        await fetchVarian();
      }
    });

    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;
    if (isConnected.value) {
      // fetchProduct();
      await fetchTopping();
      await fetchVarian();
    }
  }
}
