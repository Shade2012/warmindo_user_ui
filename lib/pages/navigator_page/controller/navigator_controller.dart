import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/home_page/controller/schedule_controller.dart';

class NavigatorController extends GetxController {
  final scheduleController = Get.put(ScheduleController());
  var currentIndex = 0.obs;
  var menuPageArgument = 0.obs;

  void changeIndex(int index) async {
    currentIndex.value = index;
    scheduleController.fetchSchedule();
  }
  void goToHomePage() {

    currentIndex.value = 0; //index untuk homepage
  }

  void goToMenuPage({int argument = 0})  {
    menuPageArgument.value = argument; // Update the argument
    changeIndex(1); // Index for MenuPage
  }

  void goToHistoryPage()  {
    currentIndex.value = 3; // index untuk customerspage
  }

  void goToProfilePage()  {
    currentIndex.value = 4; // Index untuk SettingsPage
  }
}
