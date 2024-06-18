import 'package:get/get.dart';

class NavigatorController extends GetxController {
  var currentIndex = 0.obs;
  var menuPageArgument = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
  void goToHomePage() {
    currentIndex.value = 0; //index untuk homepage
  }

  void goToMenuPage({int argument = 0}) {
    menuPageArgument.value = argument; // Update the argument
    changeIndex(1); // Index for MenuPage
  }

  void goToHistoryPage() {
    currentIndex.value = 3; // index untuk customerspage
  }

  void goToProfilePage() {
    currentIndex.value = 4; // Index untuk SettingsPage
  }
}
