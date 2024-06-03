import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/global_variables.dart';
import '../../../routes/AppPages.dart';
import '../../veritification_page/controller/veritification_controller.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  var obscureText = true.obs;
  final ctrUsername2 = RxString("");
  final ctrPassword2 = RxString("");
  final ctrPhoneNumber2 = RxString("");
  final ctrEmail2 = RxString("");
  final ctrPhone2 = RxString("");
  final token = RxString("");
  RxString phone_number = "".obs;

  Future<void> registerUser(String name, String username, String phoneNumber, String email, String password) async {
    isLoading.value = true;
    final url = Uri.parse(GlobalVariables.apiRegisterUrl);

    final client = http.Client();
    try {
      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'username': username,
          'phone_number': phoneNumber,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        print(response.statusCode);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token2', responseData['token']);
        phone_number.value = responseData['data']['phone_number'];
        Get.toNamed(Routes.VERITIFICATION_PAGE);
      } else if (response.statusCode == 422) {
        final responseData = jsonDecode(response.body);
        print('Error: ${responseData['message']}');
        Get.snackbar(
          'Error',
          responseData['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        final responseData = jsonDecode(response.body);
        print('Error: ${response.statusCode}');
        Get.snackbar(
          'Error',
          '${responseData['message']}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        'Akun Sudah ada',
        snackPosition: SnackPosition.TOP  ,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      client.close();
      isLoading.value = false;
    }
  }
}
