import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/pages/cart_page/model/cartmodel.dart';
import 'package:warmindo_user_ui/pages/menu_page/model/menu_model.dart';

import '../../pages/cart_page/controller/cart_controller.dart';
import '../../pages/cart_page/view/cart_page.dart';
import '../counter/counter_controller.dart';
import 'guest_reusable_card.dart';
import 'myCustomPopup.dart';

class MyCustomPopUpController extends GetxController {
  final CartController cartController = Get.put(CartController());
  final CounterController counterController = Get.put(CounterController());

  void showCustomModalForItem(Menu product, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => MyCustomPopUp(product: product),
    );
    counterController.reset();
  }
  void showCustomModalForGuest(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => GuestReusableCard() ,elevation: 0,
    );
  }

  void addToCart(Menu product) {
    cartController.addToCart(CartItem(
      productId: product.id,
      productName: product.name,
      price: product.price,
      quantity: counterController.quantity?.value ?? 0,
      productImage: product.imagePath,
    ));
    counterController.reset();
    print('Item added to cart');
    Get.back();
    print('Navigating to CartPage');
  }
}
