import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/guest_profile_page/controller/guest_profile_controller.dart';

class GuestProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuestProfileController>(() => GuestProfileController());
  }
}