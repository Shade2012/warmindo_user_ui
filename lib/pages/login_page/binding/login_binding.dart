import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/login_page/controller/login_controller.dart';

class LoginPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}