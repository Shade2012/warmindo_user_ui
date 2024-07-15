import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_user_ui/pages/edit-profile/controller/edit_profile_controller.dart';

import '../../../common/global_variables.dart';
class VerificationProfileController extends GetxController{
  final formKey = GlobalKey<FormState>();
  final EditProfileController profileController = Get.put(EditProfileController());
  final phoneNumberController = TextEditingController();
  final TextEditingController code7Controller = TextEditingController();
  final TextEditingController code8Controller = TextEditingController();
  final TextEditingController code9Controller = TextEditingController();
  final TextEditingController code10Controller = TextEditingController();
  final TextEditingController code11Controller = TextEditingController();
  final TextEditingController code12Controller = TextEditingController();
  RxString txtPhoneNumber = ''.obs;
  RxBool isLoading = true.obs;
  final isFilled = false.obs;
  SharedPreferences? prefs;
  RxString codeOtp = ''.obs;
  RxString token = "".obs;
  RxBool isConnected = true.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkConnectivity();
    code7Controller.addListener(updateFilledStatus);
    code8Controller.addListener(updateFilledStatus);
    code9Controller.addListener(updateFilledStatus);
    code10Controller.addListener(updateFilledStatus);
    code11Controller.addListener(updateFilledStatus);
    code12Controller.addListener(updateFilledStatus);
  }
  void updateFilledStatus() {
    if (code7Controller.text.isNotEmpty &&
        code8Controller.text.isNotEmpty &&
        code9Controller.text.isNotEmpty &&
        code10Controller.text.isNotEmpty &&
        code11Controller.text.isNotEmpty &&
        code12Controller.text.isNotEmpty) {
      isFilled.value = true;

    } else {
      isFilled.value = false;
    }
    codeOtp.value = ('${code7Controller.text}${code8Controller.text}${code9Controller.text}${code10Controller.text}${code11Controller.text}${code12Controller.text}');
  }
  Future<void> initializePrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }
  Future<void> sendOtp() async {
    try {
      final uri = Uri.parse(GlobalVariables.apiSendOtp);
      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Content-Type'] = 'multipart/form-data'
        ..headers['Accept'] = 'application/json';
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
  void checkSharedPreference() async {
    await initializePrefs();
    if (prefs != null) {
      token.value = prefs!.getString('token') ?? '';
      try {
        isLoading.value = true; // Set loading to true before fetching data
        final response = await http.get(Uri.parse(GlobalVariables.apiDetailUser),headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          if (data['success']) {
            txtPhoneNumber.value = data['user']['phone_number'];
            phoneNumberController.text = txtPhoneNumber.value;
            print("Fetched username: ${txtPhoneNumber.value}");
          } else {
            print('Error: ${data['message']}');
          }
        } else {
          print('Error: ${response.statusCode}');
        }
      } catch (e) {
        print('Exception: $e');
      } finally {
        isLoading.value = false; // Set loading to false after data is fetched
      }
    }
  }
  void checkConnectivity() async {
    await initializePrefs();
    if (prefs != null) {

      token.value = prefs!.getString('token') ?? '';
    }
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isConnected.value = result != ConnectivityResult.none;
      if (isConnected.value) {
        checkSharedPreference();
      }
    });

    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;
    if (isConnected.value) {
      checkSharedPreference();
    }
  }
  Future<void> editPhoneNumber({
    String? phone_number,
  }) async {
    final url = Uri.parse(GlobalVariables.apiUpdatePhoneNumber);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final client = http.Client();
    try {
      isLoading.value = true;
      // Prepare the body of the request
      final Map<String, dynamic> requestBody = {
        'phone_number': phone_number,
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
      print(response.body);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Error occurred: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

}