import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/common/model/cartmodel.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/common/model/menu_model.dart';
import 'package:warmindo_user_ui/common/model/toppings.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:http/http.dart' as http;
import '../../common/global_variables.dart';
import '../../common/model/varians.dart';
import '../../pages/cart_page/controller/cart_controller.dart';
import '../../pages/cart_page/view/cart_page.dart';
import '../counter/counter_controller.dart';
import 'guest_reusable_card.dart';
import 'myCustomPopup.dart';

class MyCustomPopUpController extends GetxController {
  RxBool isLoading = true.obs;
  RxInt quantity = 0.obs;
  // List<ScheduleList> topping = <ScheduleList>[];
  RxList<ToppingList> toppingList = <ToppingList>[].obs;
  RxList<VarianList> varianList = <VarianList>[].obs;
  // var selectedVarian = Rxn<VarianList>();
  final selectedVarian = <int, VarianList?>{}.obs;
  var selectedToppings = <int, List<ToppingList>>{}.obs;
  // var selectedToppings = <ToppingList>[].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await fetchTopping();
    await fetchVarian();

  }
  final CartController cartController = Get.put(CartController());

  Future<void> fetchSelectedToppings(int productId) async {
    final cartItem = cartController.cartItems2.firstWhereOrNull((item) => item.productId == productId);
    if (cartItem != null) {
      selectedToppings[productId] = cartItem.selectedToppings ?? [];
    } else {
      selectedToppings[productId] = [];
    }
  }
  Future<void> fetchSelectedVarian(int productId) async {
    final cartItem = cartController.cartItems2.firstWhereOrNull((item) => item.productId == productId);
    if (cartItem != null) {
      selectedVarian[productId] = cartItem.selectedVarian;
      print('Fetched selected varian: ${selectedVarian[productId]}');
    } else {
      selectedVarian[productId] = null;
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
        final data = jsonDecode(response.body);
        print('ini response : \n $data');
        print('ini list topping : \n${toppingList.value}');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');

    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchVarian () async{
    print('menjalankan fetch varian');
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

        print('ini response varian: \n $data');
        print('ini list varian : \n${varianList.value}');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');

    } finally {
      isLoading.value = false;
    }
  }
  void showCustomModalForItem(MenuList product, BuildContext context, int quantity, {required int cartid}) async {
  await fetchSelectedToppings(product.menuId);
    await fetchSelectedVarian(product.menuId);

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black54, // Set a semi-transparent barrier color
        builder: (BuildContext context) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.7,
                minChildSize: 0.25,
                maxChildSize: 1,
                expand: true,
                builder: (BuildContext context, ScrollController scrollController) {
                  return MyCustomPopUp(
                    product: product,
                    quantity: quantity.obs,
                    cartid: cartid,
                    scrollController: scrollController,
                  );
                },
              ),
            ),
          );
        },
      );
  }





  void updateQuantity(int newQuantity) {
    quantity.value = newQuantity;
  }
  void showCustomModalForGuest(BuildContext context) {

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) => GuestReusableCard() ,elevation: 0,
      );

  }

  void addToCart({required int menuId, required int quantity}) async {
    final newCartItem = await cartController.addCart(menuID: menuId, quantity: quantity);
    if (newCartItem != null) {
      print('Item added to cart: ${newCartItem.productName}');
    } else {
      print('Failed to add item to cart');
    }
  }
  void addToCart2({required MenuList product, required int quantity}) async {
    final newCartItem = await cartController.addToCart2(productId: product.menuId, productName: product.nameMenu, productImage: product.image, price: product.price, quantity: quantity);
    if (newCartItem != null) {
      print('Item added to cart: ${newCartItem.productName}');
    } else {
      print('Failed to add item to cart');
    }
  }


  void toggleTopping(int menuId, ToppingList toppingItem) {
    if (selectedToppings[menuId] == null) {
      selectedToppings[menuId] = [];
    }
    if (selectedToppings[menuId]!.contains(toppingItem)) {
      selectedToppings[menuId]!.remove(toppingItem);
    } else {
      selectedToppings[menuId]!.add(toppingItem);
    }
    selectedToppings.refresh();
  }

}


