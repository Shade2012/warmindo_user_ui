import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/home_page/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}