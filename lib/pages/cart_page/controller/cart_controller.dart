import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_user_ui/widget/myCustomPopUp/myCustomPopup.dart';
import 'package:warmindo_user_ui/widget/reusable_dialog.dart';
import '../../../common/global_variables.dart';
import '../../../common/model/cartmodel.dart';
import '../../../routes/AppPages.dart';
import '../../menu_page/controller/menu_controller.dart';

class CartController extends GetxController {
  late final SharedPreferences prefs;
  RxBool isConnected = true.obs;
  final MenuPageController menuController = Get.find<MenuPageController>();
  RxString id = ''.obs;
  RxString userPhone = ''.obs;
  RxString userPhoneVerified = ''.obs;
  RxString token = "".obs;
  final RxList<CartItem> cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkConnectivity();
  }
  final RxBool isLoading = false.obs;

  Future<void> fetchCart() async {
    try {
      isLoading.value = true;

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
      print('error');
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchUser() async {
    token.value = prefs!.getString('token') ?? 't';
    try {
      final response = await http.get(
        Uri.parse('${GlobalVariables.apiDetailUser}'),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        userPhone.value = data['user']['phone_number'] ?? '';
        userPhoneVerified.value = data['user']['phone_verified_at'] ?? '';
        print('phone verified di controller ${userPhoneVerified.value}');
      }else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print(e);

    }
  }
  Future<CartItem?> addCart({required int menuID, required int quantity}) async {
    isLoading.value = true;
    final url = Uri.parse(GlobalVariables.apiCartStore);

    final client = http.Client();
    try {
        final response = await client.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'user_id': id.value,
            'menuID': menuID,
            'quantity': quantity,
          }),
        );
        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          int menuId= responseData['data']['menuID'];
          int cartId= responseData['data']['cart_id'];
          final menu = menuController.menuElement.firstWhere((menu) => menu.menuId == menuId);
          final newCartItem2 = CartItem(
            productId: menu.menuId,
            productName: menu.nameMenu,
            price: menu.price.toDouble(),
            quantity: 1.obs,
            productImage: menu.image,
            cartId:cartId,
          );
          print('testing : $newCartItem2');
          cartItems.add(newCartItem2);

          cartItems.refresh();

        } else {
          print('Error: ${response.statusCode}');
          return null;
        }


    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        'An error occurred while processing your request',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    } finally {
      client.close();
      isLoading.value = false;
    }
  }

  Future<void> removeCart({required int idCart,}) async {
    isLoading.value = true;
    final url = Uri.parse('${GlobalVariables.apiCartDelete}${idCart}');

    final client = http.Client();
    try {
      final response = await client.delete(
        url,
        headers: {'Content-Type': 'application/json'},
      );
//200 and 401

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);

        cartItems.refresh();
        print(response.statusCode);
      }else{
        print(response);
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        'An error occurred while processing your request',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      client.close();
      isLoading.value = false;
    }
  }
  Future<void> editCart({required int idCart,required int quantity}) async {
    final url = Uri.parse('${GlobalVariables.apiCartEdit}$idCart${GlobalVariables.userQuery}$id${GlobalVariables.quantityQuery}$quantity');

    final client = http.Client();
    try {
      final response = await client.put(
        url,
        headers: {'Content-Type': 'application/json'},
      );
//200 and 401

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        print(response.statusCode);
        cartItems.refresh();
      }else{
        print(response);
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        'An error occurred while processing your request',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      client.close();
    }
  }
  void goToVerification() async{
    Get.back();
    await prefs.setString('token2', '${prefs.getString('token')}');
    Get.toNamed(Routes.VERITIFICATION_PAGE,arguments: {'isLogged': true.obs,});
  }
  void checkConnectivity() async {
    prefs = await SharedPreferences.getInstance();
    id.value = prefs.getString('user_id') ?? '';
   await prefs.setString('token2', '${prefs.getString('token')}');
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      isConnected.value = result != ConnectivityResult.none;
      if (isConnected.value) {
        //fetch cart
        // fetchProduct();
      fetchUser();
        fetchCart();
      }
    });

    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;
    if (isConnected.value) {
      //fetch cart
      fetchUser();
      fetchCart();
    }
  }

  void removeItemFromCartWithID(int cartId) {
    final item = cartItems.firstWhereOrNull((item) => item.cartId == cartId);
      cartItems.remove(item);
      removeCart(idCart: cartId);
      cartItems.refresh();

  }

  void removeItemFromCart(CartItem item) {
    cartItems.remove(item);
    removeCart(idCart: item!.cartId ?? 0);
    cartItems.refresh();
  }

  void incrementQuantity(CartItem item) {
    item.quantity++;
    editCart(idCart: item!.cartId ?? 0 , quantity: item.quantity.value);
    cartItems.refresh();
  }

  void decrementQuantity(CartItem item) {
    if (item.quantity > 0) {
      item.quantity--;
      editCart(idCart: item!.cartId ?? 0 , quantity: item.quantity.value);
      if (item.quantity == 0) {
        // If the quantity becomes zero, remove the item from the cart
        removeItemFromCart(item);
      }
      cartItems.refresh();
    }
  }
}
