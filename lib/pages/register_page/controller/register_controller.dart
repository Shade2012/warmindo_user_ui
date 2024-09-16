import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/global_variables.dart';
import '../../../routes/AppPages.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  var obscureText = true.obs;
  final ctrUsername2 = RxString("");
  final ctrPassword2 = RxString("");
  final ctrPhoneNumber2 = RxString("");
  final ctrEmail2 = RxString("");
  final ctrPhone2 = RxString("");
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
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', responseData['token']);
        await prefs.setString('token4', responseData['token']);
        phone_number.value = responseData['data']['phone_number'];
        Get.toNamed(Routes.VERITIFICATION_PAGE, arguments: {'isLogged': false.obs,});
      }
      else if(responseData['success'] == false) {
        final List<String> errorMessages = [];

        if (responseData['errors']['username'] != null) {
          errorMessages.add((responseData['errors']['username'] as List).join('\n'));
        }
        if (responseData['errors']['email'] != null) {
          errorMessages.add((responseData['errors']['email'] as List).join('\n'));
        }
        if (responseData['errors']['phone_number'] != null) {
          errorMessages.add((responseData['errors']['phone_number'] as List).join('\n'));
        }

        Get.snackbar(
          'Error',
          errorMessages.join('\n'),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
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
