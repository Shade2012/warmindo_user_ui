import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/cart_page/controller/cart_controller.dart';
import 'package:warmindo_user_ui/pages/history_page/controller/history_controller.dart';
import 'package:warmindo_user_ui/pages/home_page/controller/schedule_controller.dart';
import 'package:warmindo_user_ui/pages/menu_page/controller/menu_controller.dart';

class NavigatorController extends GetxController {
  final scheduleController = Get.put(ScheduleController());
  final menuController = Get.put(MenuPageController());
  final cartController = Get.put(CartController());
  final historyController = Get.put(HistoryController());
  var currentIndex = 0.obs;
  var menuPageArgument = 0.obs;

  void changeIndex(int index) async {
    historyController.fetchHistory();
    cartController.fetchCart();
    currentIndex.value = index;
    menuController.fetchProduct();
    scheduleController.fetchSchedule();
  }
  void goToHomePage() {
    // historyController.isLoading.value = true;
    currentIndex.value = 0; //index untuk homepage
  }

  void goToMenuPage({int argument = 0})  {
    // historyController.isLoading.value = true;
    menuPageArgument.value = argument; // Update the argument
    changeIndex(1); // Index for MenuPage
  }

  void goToHistoryPage() async   {
    currentIndex.value = 3; // index untuk customerspage
  }

  void goToProfilePage()  {
    // historyController.isLoading.value = true;
    currentIndex.value = 4; // Index untuk SettingsPage
  }
}
