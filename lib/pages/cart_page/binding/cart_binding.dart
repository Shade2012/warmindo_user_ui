import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/cart_page/controller/cart_controller.dart';

import '../../../widget/myCustomPopUp/myPopup_controller.dart';
import '../../home_page/controller/schedule_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy initialization of ScheduleController
    Get.lazyPut<ScheduleController>(() => ScheduleController());

    // Lazy initialization of CartController
    Get.lazyPut<CartController>(() => CartController());

    // Lazy initialization of MyCustomPopUpController
    Get.lazyPut<MyCustomPopUpController>(() => MyCustomPopUpController());
  }
}
