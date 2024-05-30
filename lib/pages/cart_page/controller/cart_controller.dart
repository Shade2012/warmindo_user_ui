import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/history_page/controller/history_controller.dart';
import 'package:warmindo_user_ui/pages/pembayaran-page/controller/pembayaran_controller.dart';

import '../../../common/model/history.dart';
import '../../voucher_page/controller/voucher_controller.dart';
import '../../../common/model/cartmodel.dart';

class CartController extends GetxController {


  RxInt quantity = 1.obs;
  // final RxList<CartItem> cartItems = cartList.obs;
  final RxList<CartItem> cartItems = <CartItem>[].obs;



  void addToCart(CartItem item) {
    final existingItemIndex = cartItems.indexWhere((cartItem) => cartItem.productId == item.productId);
    if (existingItemIndex != -1) {
      cartItems[existingItemIndex].quantity += item.quantity;
    } else {
      cartItems.add(item);
    }
    cartItems.refresh();
  }

  // Remove an item from the cart
  void removeItemFromCart(int index) {
    cartItems.removeAt(index);
    cartItems.refresh();
  }

  // Increment the quantity of an item at a specific index
  void incrementQuantity(int index) {
    cartItems[index].quantity++;
    cartItems.refresh();
  }

  // Decrement the quantity of an item at a specific index
  void decrementQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      if (cartItems[index].quantity > 0) {
        cartItems[index].quantity--;

        if (cartItems[index].quantity == 0) {
          // If the quantity becomes zero, remove the item from the cart
          removeItemFromCart(index);
        }
        cartItems.refresh();
      }
    }
  }
}
