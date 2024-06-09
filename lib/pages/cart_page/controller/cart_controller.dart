import 'package:get/get.dart';

import '../../../common/model/cartmodel.dart';

class CartController extends GetxController {
  final RxList<CartItem> cartItems = <CartItem>[].obs;

  void addToCart(CartItem product) {
    final existingItemIndex = cartItems.indexWhere((item) => item.productId == product.productId);

    if (existingItemIndex != -1) {
      incrementQuantityPopup(existingItemIndex);
    } else {
      // Add the product directly to the cartItems list
      cartItems.add(product);
    }

    print('Item added to cart');
    print('Navigating to CartPage');
  }




  void removeItemFromCart(CartItem item) {
    cartItems.remove(item);
    cartItems.refresh();
  }

  void incrementQuantity(CartItem item) {
    item.quantity++;
    cartItems.refresh();
  }

  void decrementQuantity(CartItem item) {
    if (item.quantity > 0) {
      item.quantity--;

      if (item.quantity == 0) {
        // If the quantity becomes zero, remove the item from the cart
        removeItemFromCart(item);
      }
      cartItems.refresh();
    }
  }

  void incrementQuantityPopup(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index].quantity.value++;
    }
  }

  void decrementQuantityPopup(int index) {
    if (index >= 0 && index < cartItems.length) {
      if (cartItems[index].quantity.value > 0) {
        cartItems[index].quantity.value--;
      } else if (cartItems[index].quantity.value == 1){
        removeItemFromCart(cartItems[index]);
      }
    }

  }

}
