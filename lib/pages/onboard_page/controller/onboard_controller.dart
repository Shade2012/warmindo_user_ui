import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardController extends GetxController {
  final PageController pageController = PageController();

  RxInt currentPage = 0.obs;

  void nextPage() {
    currentPage.value++;
    if (currentPage.value >= 3) {
      // Jika sudah sampai halaman terakhir, pindah ke halaman selanjutnya
      Get.offAllNamed('/home');
    } else {
      pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

   void goToPage(int page) {
    currentPage.value = page;
    pageController.animateToPage(
      currentPage.value,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
}