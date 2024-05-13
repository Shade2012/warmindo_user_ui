import 'dart:ffi';

import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/cart_page/controller/cart_controller.dart';
import 'package:warmindo_user_ui/pages/pembayaran-page/view/pembayaran_complete_view.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';

class PembayaranController extends GetxController{
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
void paid (){
Get.off(PembayaranComplate());
cartController.cartItems.clear();
}
}

