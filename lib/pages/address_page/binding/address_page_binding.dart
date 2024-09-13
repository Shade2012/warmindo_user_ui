import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/address_page/controller/address_page_controller.dart';

class AddressPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressPageController>(() => AddressPageController());
  }
}
