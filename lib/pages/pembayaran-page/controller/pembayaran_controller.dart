import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/common/model/toppings.dart';
import 'package:warmindo_user_ui/common/model/varians.dart';

import 'package:warmindo_user_ui/pages/cart_page/controller/cart_controller.dart';
import 'package:warmindo_user_ui/pages/history_page/controller/history_controller.dart';
import 'package:warmindo_user_ui/pages/pembayaran-page/view/pembayaran_complete_view.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';

import '../../../common/model/cart_model2.dart';
import '../../../common/model/history.dart';
import '../../../common/model/menu_model.dart';



class PembayaranController extends GetxController{
  late final TextEditingController ctrCatatan = TextEditingController();
  final HistoryController historyController = Get.put(HistoryController());

  final CartController cartController = Get.put(CartController());
RxBool isLoading = false.obs;
RxBool selected = false.obs;
RxBool selectedButton1 = false.obs;
RxBool selectedButton2 = false.obs;

  void button1 (){
    selectedButton1.value = true;
    selectedButton2.value = false;
  }
void button2 (){
  selectedButton2.value = true;
  selectedButton1.value = false;
}
int generateOrderId() {
  return DateTime.now().millisecondsSinceEpoch; // Example: Using timestamp as order ID
}
  String getPaymentMethod() {
    if (selectedButton1.value) {
      return 'OVO';
    } else if (selectedButton2.value) {
      return 'DANA';
    } else {
      // Default payment method if neither button is selected
      return 'Default Payment Method';
    }
  }
void makePayment({
  required String catatan}) async  {
  int totalPrice2 = 0;
  isLoading.value = true;
  for (CartItem2 cartItem in cartController.cartItems2) {
    int toppingTotalPrice = 0;
    if (cartItem.selectedToppings != null) {
      for (var topping in cartItem.selectedToppings!) {
        toppingTotalPrice += topping.priceTopping;
      }
    }
    totalPrice2 += (cartItem.price + toppingTotalPrice) * cartItem.quantity.value;
  }
  String paymentMethod = getPaymentMethod();
    List<MenuList> orderedMenus = cartController.cartItems2.map((item) => MenuList(
      menuId: item.productId,
      nameMenu: item.productName,
      price: item.price,
      image: item.productImage,
      quantity: item.quantity.value, category: '', description: '',
      variantId: item.selectedVarian?.varianID,
      toppings: item.selectedToppings
    )).toList();

  List<VarianList> varianList = cartController.cartItems2
      .where((item) => item.selectedVarian != null) // Filter out items with null selectedVarian
      .map((item) => item.selectedVarian!) // Extract the VarianList from each CartItem2
      .toList();

  List<ToppingList> toppingList = cartController.cartItems2
      .expand((item) => item.selectedToppings ?? [])  // Use 'expand' to flatten the list
      .map((topping) => ToppingList(
    toppingID: topping.toppingID,
    nameTopping: topping.nameTopping,
    priceTopping: topping.priceTopping,
  ))
      .toList();
    Order order = Order(
      id: generateOrderId(),
      menus: orderedMenus,
      status: 'Sedang Diproses'.obs,
      orderMethod: 'Takeaway',
      paymentMethod: paymentMethod,
      selectedToppings: toppingList,
      selectedVarian: varianList,

      paid: true,
      catatan: catatan ?? '-', alasan_batal: ''.obs,
      totalprice: totalPrice2,

    );

    saveOrderToHistory(order);
  for (CartItem2 item in cartController.cartItems2) {
    await cartController.removeCart(idCart: item.cartId!);
  }

  cartController.cartItems2.clear();
  isLoading.value = false;
    Get.off(PembayaranComplate()); // Navigate to the completion view


}


void saveOrderToHistory(Order order) {
  final existingItemIndex = historyController.orders.indexWhere((orderlist) => orderlist.status == order.status);
  historyController.saveOrderToHistory(order);
  // historyController.orders.add(order);
}
}

