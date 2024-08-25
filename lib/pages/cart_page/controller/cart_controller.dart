import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_user_ui/pages/home_page/controller/schedule_controller.dart';
import '../../../common/global_variables.dart';
import '../../../common/model/cart_model2.dart';
import '../../../common/model/toppings.dart';
import '../../../common/model/varians.dart';
import '../../../routes/AppPages.dart';
import '../../menu_page/controller/menu_controller.dart';

class CartController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxBool isLoadingButton = false.obs;
  late final SharedPreferences prefs;
  RxBool isConnected = true.obs;
  final ScheduleController scheduleController = Get.put(ScheduleController());
  final MenuPageController menuController = Get.put(MenuPageController());
  int id = 0;
  RxString userPhone = ''.obs;
  RxString userPhoneVerified = ''.obs;
  RxString token = "".obs;
  RxString responseData = "".obs;
  final RxList<CartItem2> cartItems2 = <CartItem2>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkConnectivity();
  }


  Future<void> fetchCart() async {
    isLoading.value = true;
    try {
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
        cartItems2.sort((a, b)=> b.price.compareTo(a.price));
      } else {
        cartItems2.clear();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> fetchSchedule() async {

    try {
      print('melakukan fetch schedule');
      // Perform the fetch operation
      isLoadingButton.value = true;
      await scheduleController.fetchSchedule(); // Example: Assuming getSchedule is your fetching method
      isLoadingButton.value = false;
      return true;
    } catch (e) {
      print("Error fetching schedule: $e");
      return false;
    }
  }

  Future<void> fetchUser() async {
    token.value = prefs.getString('token') ?? '';
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
      }else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      print('ada error di fetch user');

    }
  }
  Future<void> postCartItems2({
    required int productId,
    required int quantity,
    VarianList? selectedVarian,
    List<ToppingList>? selectedToppings,
    required String productName,
    required String productImage,
    required int price,
    required RxInt cartid,
  }) async {
    const url = GlobalVariables.apiCartStore;
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
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
        if (response.statusCode == 201) {
          final responseData = jsonDecode(response.body);
          final newCartId = responseData['data']['id'];
          final cartItem = cartItems2.firstWhereOrNull((item) => item.cartId?.value  == 0);

          if (cartItem != null) {
            cartItem.cartId?.value = newCartId;
            cartid.value = newCartId;
            cartItems2.refresh();
          }
          fetchCart();
          cartItems2.refresh();
        } else {
        print('Failed to post cart items: ${response.statusCode}');
      }
    } catch (e) {
      print('Error posting cart items: $e');
    }
  }



  Future<CartItem2?> addToCart2({
    required int productId,
    BuildContext? context,
    required String productName,
    required String productImage,
    required int price,
    required int cartID,
    VarianList? selectedVarian,
    List<ToppingList>? selectedToppings,
    required int quantity,
  }) async {
    final existingItem = cartItems2.firstWhereOrNull((item) {
      bool sameMenuId = item.productId == productId;
      bool sameVarian = (item.selectedVarian?.varianID == selectedVarian?.varianID);
      bool sameToppings = const DeepCollectionEquality.unordered()
          .equals(item.selectedToppings, selectedToppings);

      return sameMenuId && sameVarian && sameToppings;
    });

    CartItem2 newItem;

    if (existingItem == null) {

      newItem = CartItem2(
        productId: productId,
        productName: productName,
        productImage: productImage,
        price: price,
        quantity: quantity.obs,
        selectedVarian: selectedVarian,
        selectedToppings: selectedToppings ?? [],
        cartId: 0.obs,
      );

      cartItems2.add(newItem);
      await postCartItems2(
        productId: productId,
        quantity: quantity,
        selectedVarian: selectedVarian,
        selectedToppings: selectedToppings,
        productName: productName,
        productImage: productImage,
        price: price, cartid: cartID.obs,
      );
      cartItems2.refresh();
    }

    else {
      existingItem.quantity.value += quantity;
      newItem = existingItem;
      await editCart(
        idCart: newItem.cartId?.value ?? 0,
        quantity: newItem.quantity.value,
        menuID: newItem.productId,
      );
      cartItems2.refresh();
    }
    cartItems2.refresh();
    return newItem;
  }


  Future<void> editCart({
    required int idCart,
    required int quantity,
    int? variantId,
    List<int>? toppings,
    required int menuID,
  }) async {
    final url = Uri.parse('${GlobalVariables.apiCartEdit}$idCart');

    final client = http.Client();
    final cartItems = cartItems2.firstWhereOrNull((element) => element.cartId?.value == idCart);
    final existingItem = cartItems2.firstWhereOrNull((item) {
      bool sameMenuId = item.productId == menuID;
      bool sameVarian = (item.selectedVarian?.varianID == variantId);
      bool sameToppings = const DeepCollectionEquality.unordered()
          .equals(item.selectedToppings, cartItems?.selectedToppings);

      return sameMenuId && sameVarian && sameToppings ;
    });

    try {

      if (existingItem != null) {
        final url2 = Uri.parse('${GlobalVariables.apiCartEdit}${existingItem?.cartId}');
        print('sudah ada $existingItem');
        print('cart baru $cartItems');
        print('idcart  $idCart');
        int? totalquantity = cartItems!.quantity.value + existingItem.quantity.value;
        print('quantity gabungan $totalquantity');
        // Proceed with the manual update
        final data = <String, dynamic>{
          "quantity": (existingItem.cartId == cartItems.cartId)
              ? cartItems.quantity.value
              : cartItems.quantity.value + existingItem.quantity.value,
          "menu_id": existingItem.productId,
        };

        if (variantId != null) {
          data["variant_id"] = variantId;
        }

        data["toppings"] = toppings?.map((toppingId) => {
          "topping_id": toppingId,
          "quantity": (existingItem.cartId == cartItems.cartId)
              ? cartItems.quantity.value
              : totalquantity, // Use totalquantity here if cartId does not match
        }).toList();
        //
        final body = {
          "datas": [data],
        };
        //
        final response = await client.put(
          url2,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body),
        );

        if (response.statusCode == 200) {
          isLoading.value = true;
          print('berhasil edit cart ${response.statusCode}');
          print(cartItems.cartId?.value ?? 0);
          if(existingItem.cartId != cartItems.cartId){

          await removeItemFromCartWithID(cartItems.cartId?.value ?? 0);
          await fetchCart();
          cartItems2.refresh();
          print('berhasil ganti dan hapus');
          }else{
            await fetchCart();
            cartItems2.refresh();
          }
          final responseData = jsonDecode(response.body);
          print(responseData);
        } else {
          final responseData = jsonDecode(response.body);
          Get.snackbar('Pesan', '${response.statusCode} Terlalu banyak aksi, server sedang sibuk');
          print('Failed to edit cart: ${jsonDecode(response.statusCode.toString())}');
          print(responseData);
        }
      }else{
        final data = <String, dynamic>{
          "quantity": quantity,
          "menu_id": menuID,
        };

        if (variantId != null) {
          data["variant_id"] = variantId;
        }

        data["toppings"] = toppings?.map((toppingId) => {
          "topping_id": toppingId,
          "quantity": quantity, // Add the quantity field here
        }).toList();

        final body = {
          "datas": [data],
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

        if (response.statusCode == 200) {
          cartItems2.refresh();
          isLoading.value = true;
          final responseData = jsonDecode(response.body);
          print(responseData);
          print('berhasil edit cart');
          await fetchCart();
        } else {
          final responseData = jsonDecode(response.body);
          // Get.snackbar('Pesan', '${response.statusCode} Terlalu banyak aksi, server sedang sibuk');
          print('Failed to edit cart: ${jsonDecode(response.statusCode.toString())}');
          print(responseData);
        }
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



  Future<void> removeCart({required int idCart,}) async {
    isLoading.value = true;
    print(idCart);
    print('hapus keranjgn');
    final url = Uri.parse('${GlobalVariables.apiCartDelete}$idCart');

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
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        fetchCart();
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

  Future<void> removeItemFromCartWithID(int cartId) async {
    final item = cartItems2.firstWhereOrNull((item) => item.cartId?.value == cartId);
    cartItems2.remove(item);
      await removeCart(idCart: cartId);
      print('cart id yang dihapus $cartId');
    cartItems2.refresh();

  }

  void removeItemFromCart(CartItem2 item) {
    cartItems2.remove(item);
    removeCart(idCart: item.cartId?.value ?? 0);
    cartItems2.refresh();

  }

  void incrementQuantity(CartItem2 item) async {
    item.quantity++;
    editCart(idCart: item.cartId?.value ?? 0 , quantity: item.quantity.value, menuID: item.productId);
    // cartItems2.refresh();
  }

  void decrementQuantity(CartItem2 item) async {
      item.quantity--;
      editCart(idCart: item.cartId?.value ?? 0 , quantity: item.quantity.value, menuID: item.productId);
      if (item.quantity.value == 0) {
        // If the quantity becomes zero, remove the item from the cart
        removeItemFromCart(item);
      }
      // cartItems2.refresh();
  }
  int? getCartIdForFilter(int cartID) {
    final cartItem = cartItems2.firstWhereOrNull((item) => item.cartId?.value == cartID);
    return cartItem?.cartId?.value;
  }
  RxInt getTotalQuantityForMenuID(int menuID) {
    final items = cartItems2.where((element) => element.productId == menuID).toList();
    RxInt totalQuantity = 0.obs;

    for (var item in items) {
      totalQuantity += item.quantity.value;
    }

    return totalQuantity;
  }
}

