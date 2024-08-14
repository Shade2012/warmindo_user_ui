import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/global_variables.dart';
import '../../../common/model/cart_model2.dart';
import '../../../common/model/cartmodel.dart';
import '../../../common/model/toppings.dart';
import '../../../common/model/varians.dart';
import '../../../routes/AppPages.dart';
import '../../menu_page/controller/menu_controller.dart';

class CartController extends GetxController {
  late final SharedPreferences prefs;
  RxBool isConnected = true.obs;
  final MenuPageController menuController = Get.put(MenuPageController());
  int id = 0;
  RxString userPhone = ''.obs;
  RxString userPhoneVerified = ''.obs;
  RxString token = "".obs;
  RxString responseData = "".obs;
  final RxList<CartItem> cartItems = <CartItem>[].obs;
  final RxList<CartItem2> cartItems2 = <CartItem2>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkConnectivity();
  }


  Future<void> fetchCart() async {
    try {
      isLoading.value = true;

      final response = await http.get(Uri.parse(GlobalVariables.apiCartDetail), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data'];
        responseData.value = data.toString();
        cartItems2.clear();
        for (var item in data) {
          cartItems2.add(CartItem2.fromJson(item));
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUser() async {
    token.value = prefs!.getString('token') ?? '';
    print('print token di fetchUser Cart $token');
    try {
      final response = await http.get(
        Uri.parse(GlobalVariables.apiDetailUser),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        userPhone.value = data['user']['phone_number'] ?? '';
        userPhoneVerified.value = data['user']['phone_verified_at'] ?? '';
        id = data['user']['id'] ?? '';

        print(data['user']);
        print('phone verified di controller ${userPhoneVerified.value}');
      }else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      print('ada error di fetch user');

    }
  }
  Future<CartItem2?> addToCart2({
    required int productId,
    required String productName,
    required String productImage,
    required int price,
    VarianList? selectedVarian,
    List<ToppingList>? selectedToppings,
    required int quantity,
  }) async {
    // Check if the item is already in the cart
    final existingItem = cartItems2.firstWhereOrNull((item) => item.productId == productId);

    CartItem2 newItem;
    if (existingItem == null) {
      // Add new item to cart
      newItem = CartItem2(
        productId: productId,
        productName: productName,
        productImage: productImage,
        price: price,
        quantity: quantity.obs,
        selectedVarian: selectedVarian,
        selectedToppings: selectedToppings,
      );
      cartItems2.add(newItem);
    } else {
      // Update existing item quantity
      existingItem.quantity.value += quantity;
      newItem = existingItem;
    }
    cartItems2.refresh();
    await postCartItems2(productId: productId, quantity: quantity,selectedVarian: selectedVarian,selectedToppings:selectedToppings );
    return newItem;
  }
  Future<void> editCart({
    required int idCart,
    required int quantity,
    int? variantId,
    List<int>? toppings,
    required int menuID
  }) async {
    final url = Uri.parse('${GlobalVariables.apiCartEdit}$idCart');

    final client = http.Client();
    try {
      final data =<String, dynamic> {
        "quantity": quantity,
        "menu_id": menuID,
      };

      if (variantId != null) {
        data["variant_id"] = variantId;
      }

        data["toppings"] = toppings?.map((toppingId) => {
          "topping_id": toppingId,
          "quantity": quantity // Add the quantity field here
        }).toList();

      final body = {
        "datas": [data]
      };

      final response = await client.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );
      fetchCart();
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        print(response.statusCode);
        cartItems2.refresh();
      } else {
        final responseData = jsonDecode(response.body);
        print('Failed to edit cart: ${jsonDecode(response.statusCode.toString())}');
        print(responseData);
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


  Future<void> postCartItems2({
      required int productId,
      required int quantity,
      VarianList? selectedVarian,
      List<ToppingList>? selectedToppings,
  }) async {
    final url = GlobalVariables.apiCartStore;
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',};
    final body = jsonEncode({
      "datas": [
        {
          "quantity": quantity.toInt(),
          "menu_id": productId.toInt(),
          "variant_id": selectedVarian?.varianID ?? null,
          "toppings": selectedToppings?.map((topping) => {
          "topping_id": topping.toppingID,
            "quantity": quantity
          }).toList() ?? [],
        }
      ],
    });

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);
      fetchCart();
      if (response.statusCode == 201) {

        // Success

        print(response.body);
        print('Cart items posted successfully.');
      } else {
        // Failure
        print(response.body);
        print('Failed to post cart items: ${response.statusCode}');
      }
    } catch (e) {
      print('Error posting cart items: $e');
    }
  }
  Future<void> postCartItems2ToOrder() async {
    final url = GlobalVariables.apiCartStore;
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "datas": cartItems2.map((item) => {
        "quantity": item.quantity.value,
        "menu_id": item.productId,
        "variant_id": item.selectedVarian?.varianID,
        "toppings": item.selectedToppings?.map((topping) => {
          "topping_id": topping.toppingID,
        }).toList() ?? [],
      }).toList(),
    });

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        // Success
        print('Cart items posted successfully.');
      } else {
        // Failure
        print('Failed to post cart items: ${response.statusCode}');
      }
    } catch (e) {
      print('Error posting cart items: $e');
    }
  }
  Future<CartItem?> addCart({required int menuID, required int quantity}) async {
    isLoading.value = true;
    final url = Uri.parse(GlobalVariables.apiCartStore);
    final client = http.Client();
    print(id);
    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',},
        body: jsonEncode({
          'user_id': id,
          'menuID': menuID,
          'quantity': quantity,
        }),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${jsonDecode(response.body)}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        int menuId = responseData['data']['menuID'];
        int cartId = responseData['data']['cart_id'];
        final menu = menuController.menuElement.firstWhere((menu) => menu.menuId == menuId);
        final newCartItem2 = CartItem(
          productId: menu.menuId,
          productName: menu.nameMenu,
          price: menu.price,
          quantity: 1.obs,
          productImage: menu.image,
          cartId: cartId,
        );
        print('testing : $newCartItem2');
        cartItems.add(newCartItem2);

        cartItems.refresh();

        // Return the created CartItem
        return newCartItem2;
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
    print(idCart);
    print('hapus keranjgn');
    final url = Uri.parse('${GlobalVariables.apiCartDelete}${idCart}');

    final client = http.Client();
    try {
      final response = await client.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
//200 and 401

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);

        cartItems2.refresh();
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

  void goToVerification() async{
    Get.back();
    Get.toNamed(Routes.EDITPROFILE_PAGE);
  }
  void checkConnectivity() async {
    prefs = await SharedPreferences.getInstance();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      isConnected.value = result != ConnectivityResult.none;
      if (isConnected.value) {
        isLoading.value = true;
        //fetch cart
        // fetchProduct();
       await fetchUser();
       await fetchCart();
      }
    });

    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;
    if (isConnected.value) {
      //fetch cart
      await fetchUser();
      await fetchCart();
    }
  }

  void removeItemFromCartWithID(int cartId) {
    final item = cartItems2.firstWhereOrNull((item) => item.cartId == cartId);
    cartItems2.remove(item);
      removeCart(idCart: cartId);
    cartItems2.refresh();

  }

  void removeItemFromCart(CartItem2 item) {
    cartItems2.remove(item);
    removeCart(idCart: item!.cartId ?? 0);
    cartItems2.refresh();
  }

  void incrementQuantity(CartItem2 item) async {
    item.quantity++;
    editCart(idCart: item!.cartId ?? 0 , quantity: item.quantity.value, menuID: item.productId);
    cartItems2.refresh();
  }

  void decrementQuantity(CartItem2 item) async {
      item.quantity--;
      editCart(idCart: item!.cartId ?? 0 , quantity: item.quantity.value, menuID: item.productId);
      if (item.quantity.value == 0) {
        // If the quantity becomes zero, remove the item from the cart
        removeItemFromCart(item);
      }
      cartItems2.refresh();
  }
  int? getCartIdForMenu(int menuId) {
    final cartItem = cartItems2.firstWhereOrNull((item) => item.productId == menuId);
    return cartItem?.cartId;
  }
}

