import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import '../pages/cart_page/controller/cart_controller.dart';
import '../common/model/cartmodel.dart';
import 'myCustomPopUp/myCustomPopup.dart';
import 'myCustomPopUp/myPopup_controller.dart';

class Cart extends StatelessWidget {
  final cartController = Get.put(CartController());
  final popUpcontroller = Get.put(MyCustomPopUpController());

  final BuildContext context;
  final MenuList product;

  Cart({required this.context, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await cartController.fetchCart();

        final cartItem = cartController.cartItems.firstWhereOrNull((item) => item.productId == product.menuId);
        final menuQuantity = cartItem?.quantity.value ?? 0;

        if (cartItem == null) {
          popUpcontroller.addToCart(menuId: product.menuId, quantity: 1);
          popUpcontroller.showCustomModalForItem(product, context, 1, cartid: 0); // Show with initial quantity 1
        } else {
          popUpcontroller.showCustomModalForItem(product, context, menuQuantity, cartid: cartItem.cartId ?? 0);
        }

        print(cartController.cartItems.value);
      },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: Color.fromARGB(160, 0, 0, 0),
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


