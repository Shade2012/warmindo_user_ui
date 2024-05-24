import 'dart:ffi';

import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/cart_page/controller/cart_controller.dart';
import 'package:warmindo_user_ui/pages/history_page/controller/history_controller.dart';
import 'package:warmindo_user_ui/pages/pembayaran-page/view/pembayaran_complete_view.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';

import '../../history_page/model/history.dart';
import '../../menu_page/model/menu_model.dart';
import '../../voucher_page/controller/voucher_controller.dart';

class PembayaranController extends GetxController{
  final HistoryController historyController = Get.put(HistoryController());
  final VoucherController voucherController = Get.put(VoucherController());
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
    List<Menu> orderedMenus = cartController.cartItems.map((item) => Menu(
      id: item.productId,
      name: item.productName,
      price: item.price,
      imagePath: item.productImage,
      quantity: item.quantity, category: '', description: '',
    )).toList();

    Order order = Order(
      id: generateOrderId(),
      menus: orderedMenus,
      status: 'In Progress'.obs,
      orderMethod: 'Takeaway',
      paymentMethod: paymentMethod,
      vouchers: voucherController.appliedVoucher.value != null ? [voucherController.appliedVoucher.value!] : null,
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

