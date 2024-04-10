import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/guest_menu_page/controller/guest_menu_controller.dart';

class GuestMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuestMenuController>(() => GuestMenuController());
  }
}