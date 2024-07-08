import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';
import '../../../common/global_variables.dart';
import 'package:http/http.dart' as http;
import '../../profile_page/controller/profile_controller.dart';

class ForgotPasswordController extends GetxController {
  final confirmPassword = TextEditingController();
  final newPassword = TextEditingController();
  final phoneNumberController = TextEditingController();
  final isFilled = false.obs;
  RxBool isConnected = true.obs;
  SharedPreferences? prefs;
  RxBool isLoading = true.obs;
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
    checkConnectivity();
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
    codeOtp.value = ('${code13Controller.text}${code14Controller.text}${code15Controller.text}${code16Controller.text}${code17Controller.text}${code18Controller.text}');
    print('OTP Updated: ${codeOtp.value}'); // Debugging line
  }

  Future<void> initializePrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  void checkSharedPreference() async {
    await initializePrefs();
    if (prefs != null) {
      token.value = prefs!.getString('token') ?? '';
      try {
        isLoading.value = true; // Set loading to true before fetching data
        final response = await http.get(Uri.parse(GlobalVariables.apiDetailUser), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          if (data['success']) {
            txtNomorHp.value = data['user']['phone_number'];
            phoneNumberController.text = txtNomorHp.value;
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

      final responseData = jsonDecode(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        isLoading.value = false;
        print(responseData);
        print(response.statusCode);
        Get.snackbar(
          'Success',
          'Berhasil Dirubah',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
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

  // Temporary function
  Future<void> editPassword({
    String? newPassword,
    String? confirmPassword,
  }) async {
    final url = Uri.parse(GlobalVariables.apiUpdatePhoneNumber);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final client = http.Client();

    try {
      isLoading.value = true;

      // Prepare the body of the request
      final Map<String, dynamic> requestBody = {
        // 'name': name,
        // 'username': username,
        // 'phone_number': phone_number,
        // 'email': email,
      };

      // Conditionally add the profile_picture if the image is not null
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
      print(response.statusCode);
      if (response.statusCode == 500) {
        print(response.body);
        isLoading.value = false;
      }
      if (response.statusCode == 200) {
        isLoading.value = false;
        print(responseData);
        print(response.statusCode);
        Get.toNamed(Routes.BOTTOM_NAVBAR);
        Get.snackbar(
          'Success',
          'Berhasil Dirubah',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
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
