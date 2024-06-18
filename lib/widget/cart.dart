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
    final cartItem = cartController.cartItems.firstWhereOrNull((item) => item.productId == product.menuId);

    return GestureDetector(
      onTap: () {
        if (cartItem == null) {
          final newCartItem = CartItem(
            productId: product.menuId,
            productName: product.nameMenu,
            price: product.price.toInt(),
            quantity: 1.obs,
            productImage: product.image,
          );
          popUpcontroller.addToCart(newCartItem);
          popUpcontroller.showCustomModalForItem(product, context, newCartItem);
        } else {
          popUpcontroller.showCustomModalForItem(product, context, cartItem);
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
