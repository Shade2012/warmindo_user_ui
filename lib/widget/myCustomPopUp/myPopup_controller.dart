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
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }
  final CartController cartController = Get.put(CartController());
  final CounterController counterController = Get.put(CounterController());

  void showCustomModalForItem(MenuList product, BuildContext context) {
    Future.delayed(Duration(milliseconds: 200), () {
      isLoading.value = false;
    });
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
       return MyCustomPopUp(product: product);
      }
    );
    counterController.reset();
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

  void addToCart(MenuList product) {
    cartController.addToCart(CartItem(
      productId: product.menuId,
      productName: product.nameMenu,
      price: product.price.toInt(),
      quantity: counterController.quantity?.value ?? 0,
      productImage: product.image,
    ));
    counterController.reset();
    print('Item added to cart');
    Get.back();
    print('Navigating to CartPage');
  }
}
