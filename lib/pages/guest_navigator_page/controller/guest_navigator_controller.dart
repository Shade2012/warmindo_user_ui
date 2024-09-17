import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/guest_menu_page/controller/guest_menu_controller.dart';

import '../../home_page/controller/schedule_controller.dart';
import '../../menu_page/controller/menu_controller.dart';

class GuestNavigatorController extends GetxController {
  final menuController = Get.put(GuestMenuController());
  final scheduleController = Get.put(ScheduleController());
  var currentIndex = 0.obs;
  var guestMenuPageArgument = 0.obs;

  void changeIndex(int index) async {
    currentIndex.value = index;
    scheduleController.fetchSchedule(true);
  }

  void goToGuestHomePage() {
    currentIndex.value = 0; // index for homepage
  }

  void goToGuestMenuPage({int argument = 0}) {
    guestMenuPageArgument.value = argument; // Update the argument
    changeIndex(1); // Index for MenuPage
  }

  void goToGuestProfilePage() {
    currentIndex.value = 2; // index for profile page
  }
}
