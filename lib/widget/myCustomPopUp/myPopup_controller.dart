import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/common/model/cartmodel.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/common/model/menu_model.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';

import '../../pages/cart_page/controller/cart_controller.dart';
import '../../pages/cart_page/view/cart_page.dart';
import '../counter/counter_controller.dart';
import 'guest_reusable_card.dart';
import 'myCustomPopup.dart';

class MyCustomPopUpController extends GetxController {
  RxBool isLoading = true.obs;
  RxInt quantity = 0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }
  final CartController cartController = Get.put(CartController());
  final CounterController counterController = Get.put(CounterController());

    void showCustomModalForItem(MenuList product, BuildContext context,int quantity,{required int cartid}) {
    Future.delayed(Duration(milliseconds: 200), () {
      isLoading.value = false;
    });
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
       return MyCustomPopUp(product: product, quantity: quantity.obs, cartid: cartid,);
      }
    );
  }
  void updateQuantity(int newQuantity) {
    quantity.value = newQuantity;
  }
  void showCustomModalForGuest(BuildContext context) {
    Future.delayed(Duration(milliseconds: 200), () {
      isLoading.value = false;
    });
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) => GuestReusableCard() ,elevation: 0,
      );

  }

  void addToCart({required int menuId, required int quantity}) async {
    final newCartItem = await cartController.addCart(menuID: menuId, quantity: quantity);
    counterController.reset();
    if (newCartItem != null) {
      print('Item added to cart: ${newCartItem.productName}');
    } else {
      print('Failed to add item to cart');
    }
  }


}
