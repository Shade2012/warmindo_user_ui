import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_user_ui/common/global_variables.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';

class VeritificationController extends GetxController {
  final TextEditingController code1Controller = TextEditingController();
  final TextEditingController code2Controller = TextEditingController();
  final TextEditingController code3Controller = TextEditingController();
  final TextEditingController code4Controller = TextEditingController();
  final TextEditingController code5Controller = TextEditingController();
  final TextEditingController code6Controller = TextEditingController();
  final isFilled = false.obs;
  RxString codeOtp = ''.obs;
  RxBool isLoading = false.obs;
  RxString phoneNumber = ''.obs;
Future<void> printShared () async {

}

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    sendOtp();

    code1Controller.addListener(updateFilledStatus);
    code2Controller.addListener(updateFilledStatus);
    code3Controller.addListener(updateFilledStatus);
    code4Controller.addListener(updateFilledStatus);
    code5Controller.addListener(updateFilledStatus);
    code6Controller.addListener(updateFilledStatus);

  }


  void updateFilledStatus() {
    if (code1Controller.text.isNotEmpty &&
        code2Controller.text.isNotEmpty &&
        code3Controller.text.isNotEmpty &&
        code4Controller.text.isNotEmpty &&
        code5Controller.text.isNotEmpty &&
        code6Controller.text.isNotEmpty) {
      isFilled.value = true;

    } else {
      isFilled.value = false;
    }
    codeOtp.value = ('${code1Controller.text}${code2Controller.text}${code3Controller.text}${code4Controller.text}${code5Controller.text}${code6Controller.text}');
  }
  String removeLeadingZero(String phoneNumber) {
    if (phoneNumber.startsWith('0')) {
      return phoneNumber.substring(1);
    }
    return phoneNumber;
  }
  Future<void> sendOtp() async {
  try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token2');
      final uri = Uri.parse(GlobalVariables.apiSendOtp);
      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Content-Type'] = 'multipart/form-data'
        ..headers['Accept'] = 'application/json';

      // Add any fields or files if necessary
      // request.fields['field_name'] = 'field_value';
      // request.files.add(http.MultipartFile.fromPath('file_field', 'file_path'));

      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        if(responseBody['status'] == 'failed'){
          Get.snackbar('Pesan', 'Coba lagi setelah 5 menit',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,);
        } else  if(responseBody['status'] == 'success') {
            Get.snackbar('Pesan', 'Kode OTP Behasil dikirim',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,);
        }
        print('OTP sent successfully');
        print('Response: ${response.body}');
      } else {
        // Error occurred
        print('Failed to send OTP: ${response.statusCode}');
        print('Response: ${response.body}');

        // Show error snackbar
        Get.snackbar(
          'Error',
          'Failed to send OTP!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // Handle error
      print('Error occurred while sending OTP: $e');

      // Show error snackbar
      Get.snackbar(
        'Error',
        '$e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> verifyOtp() async {

    final url = Uri.parse(GlobalVariables.apiVerifyOtp);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token2');
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
     if(responseData['status'] == 'failed'){
       print('OTP verification failed');
       print('Response: ${response.body}');
       Get.snackbar(
         'Error',
         'Kode OTP salah',
         snackPosition: SnackPosition.TOP,
         backgroundColor: Colors.red,
         colorText: Colors.white,
       );
     }
     else if (responseData['status'] == 'success'){
       print('OTP verification succeeded');
       Get.snackbar(
         'Success',
         'Verifikasi Berhasil',
         snackPosition: SnackPosition.TOP,
         backgroundColor: Colors.green,
         colorText: Colors.white,
       );
       print('Response: ${response.body}');
       Get.offNamed(Routes.LOGIN_PAGE);
       await prefs.remove('token2');
     }
      } else {
        // Error occurred
        print('Failed to send OTP: ${response.statusCode}');
        print('Response: ${response.body}');
        // Show error snackbar
        Get.snackbar(
          'Error',
          'Ada Kesalahan',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // Handle error
      print('Error occurred while sending OTP: $e');

      // Show error snackbar
      Get.snackbar(
        'Error',
        '$e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

}

