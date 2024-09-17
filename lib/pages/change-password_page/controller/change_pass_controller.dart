import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/global_variables.dart';

class ChangePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  final ctrPassword = RxString("");
  final token = RxString("");
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> confirmPassword({required String password,required String current_password,required String password_confirmation}) async {
    final url = Uri.parse(GlobalVariables.apiUpdatePhoneNumber);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final client = http.Client();

    try {
      isLoading.value = true;
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'password': password,
          'current_password':current_password ,
          'password_confirmation' : password_confirmation
        }),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.back();
        if(Get.isSnackbarOpen != true) {
          Get.snackbar(
            'Success',
            'Edit Password Berhasil',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      }
      else if(response.statusCode == 400) {
        if(Get.isSnackbarOpen != true) {
          Get.snackbar(
            'Error',
            'Password Saat ini tidak sesuai',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
      else if(response.statusCode == 422) {
        if(Get.isSnackbarOpen != true) {
          Get.snackbar(
            'Error',
            'Password Tidak Sama',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      if(Get.isSnackbarOpen != true) {
        Get.snackbar(
          'Error',
          'Error occurred: $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }
}
