import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/veritification_page/controller/veritification_controller.dart';

class VeritificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VeritificationController>(() => VeritificationController());
  }
}