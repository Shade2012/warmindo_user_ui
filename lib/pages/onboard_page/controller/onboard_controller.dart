import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardController extends GetxController {
  final PageController pageController = PageController();
  RxBool isLastPage = false.obs;
  RxInt currentPage = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }


   void goToPage(int page) {
    currentPage.value = page;
    pageController.animateToPage(
      currentPage.value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
}
