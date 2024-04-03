import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/register_page/controller/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}