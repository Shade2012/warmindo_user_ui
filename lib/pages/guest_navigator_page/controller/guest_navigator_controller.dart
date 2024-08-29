import 'package:get/get.dart';

import '../../home_page/controller/schedule_controller.dart';

class GuestNavigatorController extends GetxController {
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
