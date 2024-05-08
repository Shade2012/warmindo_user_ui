import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../pages/cart_page/controller/cart_controller.dart';
import '../pages/cart_page/model/cartmodel.dart';
import '../pages/menu_page/model/menu_model.dart';
import '../utils/themes/icon_themes.dart';
import 'myCustomPopUp/myCustomPopup.dart';
import 'myCustomPopUp/myPopup_controller.dart';

class Cart extends StatelessWidget {
  final cartController = Get.put(CartController());
  final popUpcontroller = Get.put(MyCustomPopUpController());

  final BuildContext context;
  final Menu product;

  Cart({required this.context,required this.product});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        popUpcontroller.showCustomModalForItem(product, context);

        print(cartController.cartItems.value);

      },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: Color.fromARGB(177, 217, 217, 217),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(
          Icons.shopping_cart,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
