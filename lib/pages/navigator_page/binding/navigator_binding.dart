import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/navigator_page/controller/navigator_controller.dart';

class NavigatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigatorController>(() => NavigatorController());
  }
}