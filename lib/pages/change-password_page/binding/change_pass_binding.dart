import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/change-password_page/controller/change_pass_controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
  }
}