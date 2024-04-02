import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/history_page/controller/history_controller.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryController>(() => HistoryController());
  }
}