import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/menu_page/controller/menu_controller.dart';

class MenuPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuController>(() => MenuController());
  }
}