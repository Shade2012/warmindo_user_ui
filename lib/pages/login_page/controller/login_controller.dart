import 'dart:convert';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_user_ui/pages/register_page/controller/register_controller.dart';
import 'package:warmindo_user_ui/pages/veritification_page/controller/veritification_controller.dart';
import 'package:warmindo_user_ui/widget/reusable_dialog.dart';
import '../../../common/global_variables.dart';
import '../../../routes/AppPages.dart';

class LoginController extends GetxController {
  final firebaseMessaging = FirebaseMessaging.instance;
  RxBool isLoading = false.obs;
  var obscureText = true.obs;
  final ctrUsername2 = RxString("");
  final ctrPassword2 = RxString("");
  RxString phone_number = "".obs;

  Future<void> loginUser(String username, String password) async {
    String? notificationToken;
    await firebaseMessaging.getToken().then((value){
      notificationToken = value;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading.value = true;
    final url = Uri.parse(GlobalVariables.apiLogin);

    final client = http.Client();
    try {
      print('token fcm di login : $notificationToken');
      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'login': username,
          'password': password,
          'notification_token': notificationToken
        }),
      );
//200 and 401

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        print(response.statusCode);
        if(responseData['user'] != null){
          final user  = responseData['user'];
          final phoneVerifiedAt = user['phone_verified_at'];
          if(phoneVerifiedAt == null){
            Get.dialog(
              ReusableDialog(
                  title: 'Login Gagal',
                  content: 'Akun belum mengkonfirmasi nomor hp. Tolong konfirmasi terlebih dahulu',
                  cancelText: "Nanti",
                  confirmText: "Verifikasi",
                  onCancelPressed: () {
                    Get.back();
                  },
                  onConfirmPressed: (){
                    prefs.setString('token', '${responseData['token']}');
                    phone_number.value = responseData['user']['phone_number'];
                    Get.toNamed(Routes.VERITIFICATION_PAGE, arguments: {
                                                    'isLogged': false.obs,
                    });
                  }
              )
            );
          }
          else{
            prefs.setString('token', '${responseData['token']}');
            prefs.setString('username', '${responseData['user']['username']}');
            prefs.setString('name', '${responseData['user']['name']}');
            prefs.setString('user_id', '${responseData['user']['id']}');
            Get.offAllNamed(Routes.BOTTOM_NAVBAR);
          }
        } else{
          Get.snackbar("Error", 'Password atau username salah');
        }
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
        print('Error: ${response.statusCode}');
        Get.snackbar(
          'Error',
          'Password atau username salah',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        'An error occurred while processing your request',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      client.close();
      isLoading.value = false;
    }
  }
}
