import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/onboard_page/controller/onboard_controller.dart';

class OnboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardController>(() => OnboardController());
  }
}