import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/edit-profile/controller/edit_profile_controller.dart';
import 'package:warmindo_user_ui/pages/forgot_password/controller/forgot_password_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}
