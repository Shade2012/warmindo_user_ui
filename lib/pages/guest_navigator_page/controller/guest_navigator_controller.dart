import 'package:get/get.dart';

class GuestNavigatorController extends GetxController {
  var currentIndex = 0.obs;
  var guestMenuPageArgument = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
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
