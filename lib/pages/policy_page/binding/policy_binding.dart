import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/policy_page/controller/policy_controller.dart';

class PolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PolicyController>(() => PolicyController());
  }
}