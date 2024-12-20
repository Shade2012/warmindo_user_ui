import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';
import '../../../common/global_variables.dart';
import 'package:http/http.dart' as http;
import '../view/forgot_password_last_page.dart';
import '../view/forgot_password_page_second.dart';

class ForgotPasswordController extends GetxController {
  var obscureText = true.obs;
  final confirmPassword = TextEditingController();
  final newPassword = TextEditingController();
  final phoneNumberController = TextEditingController();
  final isFilled = false.obs;
  RxBool isConnected = true.obs;
  SharedPreferences? prefs;
  RxBool isLoading = false.obs;
  RxString txtNomorHp = "".obs;
  RxString codeOtp = ''.obs;
  RxString token = "".obs;
  final TextEditingController code13Controller = TextEditingController();
  final TextEditingController code14Controller = TextEditingController();
  final TextEditingController code15Controller = TextEditingController();
  final TextEditingController code16Controller = TextEditingController();
  final TextEditingController code17Controller = TextEditingController();
  final TextEditingController code18Controller = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    code13Controller.addListener(updateFilledStatus);
    code14Controller.addListener(updateFilledStatus);
    code15Controller.addListener(updateFilledStatus);
    code16Controller.addListener(updateFilledStatus);
    code17Controller.addListener(updateFilledStatus);
    code18Controller.addListener(updateFilledStatus);
  }

  void updateFilledStatus() {
    if (code13Controller.text.isNotEmpty &&
        code14Controller.text.isNotEmpty &&
        code15Controller.text.isNotEmpty &&
        code16Controller.text.isNotEmpty &&
        code17Controller.text.isNotEmpty &&
        code18Controller.text.isNotEmpty) {
      isFilled.value = true;
    } else {
      isFilled.value = false;
    }
    codeOtp.value = ('${code13Controller.text}${code14Controller.text}${code15Controller.text}${code16Controller.text}${code17Controller.text}${code18Controller.text}');// Debugging line
  }




  Future<void> verifyOtp() async {
    final url = Uri.parse(GlobalVariables.apiVerifyOtp);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token3');
    final token2 = prefs.getString('token');
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
          'otp': codeOtp.value,
        }),
      );
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if(responseData['status'] == 'failed') {
          if (Get.isSnackbarOpen != true) {
            Get.snackbar(
              'Error',
              'Kode OTP salah',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        }
        else if (responseData['status'] == 'success'){
          Get.snackbar(
            'Success',
            'Verifikasi Berhasil',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          prefs.remove('token');
          Get.to(ForgotPasswordLastPage());
        }
      } else {
        // Error occurred
        // Show error snackbar
        if(Get.isSnackbarOpen != true) {
          Get.snackbar(
            'Error',
            'Ada Kesalahan',
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
          '$e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> sendOtp({String? phone_number,}) async {
    final url = Uri.parse(GlobalVariables.apiSendPhoneNumber);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading.value = true;
    final client = http.Client();
    try {

      // Prepare the body of the request
      final Map<String, dynamic> requestBody = {
        'phone_number': phone_number,
      };
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if(responseData['status'] == 'failed'){
          if(Get.isSnackbarOpen != true) {
            Get.snackbar(
              'Pesan',
              'Tolong tunggu 5 menit',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          }
        }else {
          prefs.setString('token3', '${responseData['token']}');
          Get.to(ForgotPasswordSecondPage());
          isLoading.value = false;
          Get.snackbar(
            'Success',
            'Otp berhasil dikirim',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      }else{
        if(Get.isSnackbarOpen != true) {
          Get.snackbar(
            'Error',
            'Nomor Hp tidak ditemukan',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> sendOtpWithoutPhoneNumber() async {
    final url = Uri.parse(GlobalVariables.apiSendOtp);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token3');
    isLoading.value = true;
    final client = http.Client();
    try {

      // Prepare the body of the request
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':'Bearer $token'
        },
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        prefs.setString('token2','${responseData['token']}');
        isLoading.value = false;
        if(Get.isSnackbarOpen != true) {
          Get.snackbar(
            'Success',
            'Otp Berhasil dikirim',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      }else {
        if (Get.isSnackbarOpen != true) {
          Get.snackbar(
            'Error',
            'Tunggu 5 Menit',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> forgotPassword({
    String? newPassword,
    String? confirmPassword,
  }) async {
    final url = Uri.parse(GlobalVariables.apiForgotPassword);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token3');
    final token2 = prefs.getString('token');
    final client = http.Client();

    try {
      isLoading.value = true;

      // Prepare the body of the request
      final Map<String, dynamic> requestBody = {
        'new_password': newPassword,
        'new_password_confirmation': confirmPassword,
      };

      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 500) {
        isLoading.value = false;
      }
      if (response.statusCode == 200) {
        isLoading.value = false;
        if(token2 == null){
        Get.offNamed(Routes.LOGIN_PAGE);
        Get.snackbar(
          'Success',
          'Password Berhasil Dirubah',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        }else{
          Get.offNamed(Routes.CHANGEPASS_PAGE);
          Get.snackbar(
            'Success',
            'Password Berhasil Dirubah',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }

      }
    } catch (e) {
      isLoading.value = false;
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
