import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/guest_navigator_page/view/guest_navigator_page.dart';

class GuestNavigatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuestNavigatorController>(() => GuestNavigatorController());
  }
}