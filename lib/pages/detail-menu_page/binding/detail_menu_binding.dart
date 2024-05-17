import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/detail-menu_page/controller/detail_menu_controller.dart';

class DETAILMENUBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailMenuController>(() => DetailMenuController());
  }
}
