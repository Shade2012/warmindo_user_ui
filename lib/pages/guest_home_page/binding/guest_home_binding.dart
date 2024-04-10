import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/guest_home_page/controller/guest_home_controller.dart';

class GuestHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GuestHomeController());
  }
}