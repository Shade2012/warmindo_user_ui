import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/common/model/toppings.dart';
import 'package:http/http.dart' as http;
import '../../common/global_variables.dart';
import '../../common/model/varians.dart';
import '../../pages/cart_page/controller/cart_controller.dart';
import 'detailPopup.dart';
import 'guest_reusable_card.dart';
import 'myCustomPopup.dart';

class MyCustomPopUpController extends GetxController {
  late final CartController cartController;
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
    cartController = Get.find<CartController>();
  }


  Future<void> fetchSelectedToppings(int cartid) async {
    final cartItem = cartController.cartItems2.firstWhereOrNull((item) => item.cartId == cartid);
    if (cartItem != null) {
      selectedToppings[cartid] = cartItem.selectedToppings ?? [];
    } else {
      selectedToppings[cartid] = [];
    }
  }
  Future<void> fetchSelectedVarian(int cartid) async {
    final cartItem = cartController.cartItems2.firstWhereOrNull((item) => item.cartId == cartid);
    if (cartItem != null) {
      selectedVarian[cartid] = cartItem.selectedVarian;
    } else {
      selectedVarian[cartid] = null;
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
        final data = toppingListFromJson(response.body);
        toppingList.value = data;
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
    isLoading.value = true;
    try {
      final response = await http.get(
          Uri.parse(GlobalVariables.apiVarian),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }
      );

      if (response.statusCode == 200) {
    final data = varianListFromJson(response.body);
    varianList.value = data.where((element) => element.statusVarian == "1",).toList();
        // final data = jsonDecode(response.body);
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
    cartController.fetchCart();
  await fetchSelectedToppings(cartid);
    await fetchSelectedVarian(cartid);
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
                    cartid: cartid.obs,
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
        builder: (BuildContext context) => const GuestReusableCard() ,elevation: 0,
      );

  }
  void showDetailPopupModal(BuildContext context,MenuList product) {
    cartController.fetchCart();
    showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      elevation: 0,

      builder:(context) {

        return PopupDetail(menuList: product,);
      },
    );

  }

  Future<void> addToCart2({
    required BuildContext context,
    required MenuList product,
    required int quantity,
    required int cartID,
  }) async {
    await cartController.addToCart2(
      context: context,
      productId: product.menuId,
      productName: product.nameMenu,
      productImage: product.image,
      price: product.price,
      quantity: quantity,
      cartID: cartID,
    );
  }



  void toggleTopping(int cartId, ToppingList toppingItem) {
    if (selectedToppings[cartId] == null) {
      selectedToppings[cartId] = [];
    }

    // Check the status of the topping
    if (toppingItem.statusTopping == "0") {
        selectedToppings[cartId]!.remove(toppingItem);
        toppingItem.isSelected.value = false; // Unselect the topping
    } else {
      // Normal toggle logic for available toppings
      if (selectedToppings[cartId]!.contains(toppingItem)) {
        selectedToppings[cartId]!.remove(toppingItem);
        toppingItem.isSelected.value = false;
      } else {
        selectedToppings[cartId]!.add(toppingItem);
        toppingItem.isSelected.value = true;
      }
    }

    selectedToppings.refresh();
  }


}


