import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/verification_profile_page/controller/verification_profile_controller.dart';


class VeritificationProfileBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<VerificationProfileController>(() => VerificationProfileController());
  }
}
