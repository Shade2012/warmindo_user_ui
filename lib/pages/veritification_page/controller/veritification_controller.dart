import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_user_ui/common/global_variables.dart';
import '../../cart_page/controller/cart_controller.dart';
import '../../login_page/controller/login_controller.dart';
import '../../register_page/controller/register_controller.dart';

class VeritificationController extends GetxController {
  final RegisterController registerController = Get.put(RegisterController());
  final LoginController loginController = Get.put(LoginController());
  final CartController cartController = Get.put(CartController());

  final TextEditingController code1Controller = TextEditingController();
  final TextEditingController code2Controller = TextEditingController();
  final TextEditingController code3Controller = TextEditingController();
  final TextEditingController code4Controller = TextEditingController();
  final TextEditingController code5Controller = TextEditingController();
  final TextEditingController code6Controller = TextEditingController();
  final isFilled = false.obs;
  RxString isSuccess = ''.obs;
  RxString codeOtp = ''.obs;
  RxBool isLoading = false.obs;
  RxString phoneNumber = ''.obs;

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(seconds: 1), () {
      sendOtp();
    });
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
      final token = prefs.getString('token');
      final uri = Uri.parse(GlobalVariables.apiSendOtp);
      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Content-Type'] = 'multipart/form-data'
        ..headers['Accept'] = 'application/json';


      var response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        if(responseBody['status'] == 'failed'){
          if(Get.isSnackbarOpen != true) {
            Get.snackbar('Pesan', 'Coba lagi setelah 5 menit',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,);
          }
        } else
          if(responseBody['status'] == 'success') {
            if(Get.isSnackbarOpen != true) {
              Get.snackbar('Pesan', 'Kode OTP Behasil dikirim',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green,
                colorText: Colors.white,);
            }
        }
      } else {
        if(Get.isSnackbarOpen != true) {
          Get.snackbar(
            'Error',
            'Failed to send OTP!',
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
  Future<void> verifyOtp() async {
    final url = Uri.parse(GlobalVariables.apiVerifyOtp);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final token2 = prefs.getString('token2');
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
      isSuccess.value = responseData['status'];
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
       if(Get.isSnackbarOpen != true) {
         Get.snackbar(
           'Success',
           'Verifikasi Berhasil',
           snackPosition: SnackPosition.TOP,
           backgroundColor: Colors.green,
           colorText: Colors.white,
         );
       }
       // Get.offNamed(Routes.LOGIN_PAGE);
       prefs.remove('token4');
       registerController.phone_number.value = '';
       loginController.phone_number.value = '';
     }
      } else {
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
  Future<void> editPhoneNumber({required String phoneNumber}) async {
    final url = Uri.parse(GlobalVariables.apiUpdatePhoneNumber2);
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
        body: jsonEncode({'phone_number': phoneNumber}),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if(loginController.phone_number.value == ''){
          registerController.phone_number.value = responseData['user']['phone_number'];
        } else if (registerController.phone_number.value == ''){
          loginController.phone_number.value = responseData['user']['phone_number'];
        }


        Get.back();
        if(Get.isSnackbarOpen != true) {
          Get.snackbar(
            'Success',
            'Edit Nomor HP Berhasil',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }

      } else {
        if(Get.isSnackbarOpen != true) {
          Get.snackbar(
            'Error',
            'Nomor Hp Sudah ada',
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
}

