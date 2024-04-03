import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/cart_page/controller/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController());
  }
}