import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_user_ui/common/global_variables.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import '../../../common/model/cartmodel.dart';
import '../../cart_page/controller/cart_controller.dart';
import '../view/home_detaile_page.dart';

class HomeController extends GetxController {

  RxString txtUsername = "".obs;
  RxString token = "".obs;
  late final SharedPreferences prefs;
  RxList<MenuList> menuElement = <MenuList>[].obs;
  final RxList<CartItem> cartItems = <CartItem>[].obs;
  RxBool isLoading = true.obs;
  RxBool isConnected = true.obs;
  RxString id = ''.obs;
  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
  }
  Future<void> fetchCart() async {

    try {

      final response = await http.get(
        Uri.parse('${GlobalVariables.apiCartDetail}$id'),
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data'];
        cartItems.clear();
        for (var item in data) {
          cartItems.add(CartItem.fromJson(item));
        }
        print("Fetched cart items: ${cartItems.length} items");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      print('cart error');
    } finally {
    }
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
          // Extract the name from the response
          txtUsername.value = data['user']['name'];
          print("Fetched username: ${txtUsername.value}");
        } else {
          print('Error: ${data['message']}');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading.value = false; // Set loading to false after data is fetched
    }
  }

  void checkConnectivity() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      txtUsername.value = prefs.getString('username') ?? '';
      token.value = prefs.getString('token') ?? '';
      prefs.setString('token2','${token.value = prefs.getString('token')?? ''}') ?? '';
      id.value = prefs.getString('user_id') ?? '';
    }
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isConnected.value = result != ConnectivityResult.none;
      if (isConnected.value) {
        fetchProduct();
        fetchCart();
        fetchname();
      }
    });

    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;
    if (isConnected.value) {
      fetchProduct();
      fetchCart();
      fetchname();
    }
  }

  Future<void> fetchProduct() async {
    isLoading.value = true;
    try {

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
      print('Exception: $e');
      print(menuElement.value);
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToFilteredMenu(BuildContext context, int priceThreshold) {
    final filteredMenu = menuElement.where((menu) => menu.price == priceThreshold).toList();
    Get.to(FilteredMenuPage(filteredMenu: filteredMenu, price: priceThreshold)
    );
  }
}
