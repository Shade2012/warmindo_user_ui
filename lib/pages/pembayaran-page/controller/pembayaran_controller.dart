import 'dart:ffi';

import 'package:get/get.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';

import 'package:warmindo_user_ui/pages/cart_page/controller/cart_controller.dart';
import 'package:warmindo_user_ui/pages/history_page/controller/history_controller.dart';
import 'package:warmindo_user_ui/pages/pembayaran-page/view/pembayaran_complete_view.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';

import '../../../common/model/history.dart';
import '../../../common/model/menu_model.dart';



class PembayaranController extends GetxController{
  final HistoryController historyController = Get.put(HistoryController());

  final CartController cartController = Get.put(CartController());

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
void makePayment() {
  String paymentMethod = getPaymentMethod();
    List<MenuList> orderedMenus = cartController.cartItems.map((item) => MenuList(
      menuId: item.productId,
      nameMenu: item.productName,
      price: item.price.toDouble(),
      image: item.productImage,
      quantity: item.quantity, category: '', description: '',
    )).toList();

    Order order = Order(
      id: generateOrderId(),
      menus: orderedMenus,
      status: 'In Progress'.obs,
      orderMethod: 'Takeaway',
      paymentMethod: paymentMethod,

      paid: true,
    );

    saveOrderToHistory(order);
    cartController.cartItems.clear();
    Get.off(PembayaranComplate()); // Navigate to the completion view


}


void saveOrderToHistory(Order order) {
  historyController.orders.add(order);
}
}

