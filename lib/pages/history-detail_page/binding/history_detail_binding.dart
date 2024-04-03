import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/history-detail_page/controller/history_detail_controller.dart';

class HISTORYDETAILBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HISTORYDETAILController>(() => HISTORYDETAILController());
  }
}