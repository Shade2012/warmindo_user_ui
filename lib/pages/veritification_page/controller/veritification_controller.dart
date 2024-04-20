import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VeritificationController extends GetxController {
  final TextEditingController code1Controller = TextEditingController();
  final TextEditingController code2Controller = TextEditingController();
  final TextEditingController code3Controller = TextEditingController();
  final TextEditingController code4Controller = TextEditingController();
  final isFilled = false.obs;


@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    code1Controller.addListener(updateFilledStatus);
    code2Controller.addListener(updateFilledStatus);
    code3Controller.addListener(updateFilledStatus);
    code4Controller.addListener(updateFilledStatus);
  }

  void updateFilledStatus() {
    if (code1Controller.text.isNotEmpty &&
        code2Controller.text.isNotEmpty &&
        code3Controller.text.isNotEmpty &&
        code4Controller.text.isNotEmpty) {
      isFilled.value = true;
    } else {
      isFilled.value = false;
    }
  }

}

