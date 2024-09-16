import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_user_ui/common/global_variables.dart';
import 'package:warmindo_user_ui/pages/login_page/controller/login_controller.dart';
import '../../routes/AppPages.dart';
import '../../utils/themes/image_themes.dart';


class GoogleSignInButton extends StatelessWidget {
  final firebaseMessaging = FirebaseMessaging.instance;
  final LoginController loginController = Get.put(LoginController());
  GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        signIn(context);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 40, bottom: 20),
        padding: const EdgeInsets.all(5),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 3, // Spread radius
              blurRadius: 3, // Blur radius
              offset: const Offset(0, 3), // Offset
            ),
          ],
        ),
          child: Image.asset(Images.google),
      ),
    );
  }

  void signIn(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? notificationToken;
    await firebaseMessaging.getToken().then((value){
      notificationToken = value;
    });
    loginController.isLoading.value = true;
    try {
      //sementara ada signout disini dulu
      await GoogleSignIn().signOut();
      final user = await GoogleSignIn().signIn();

    final response = await http.post(
      Uri.parse(GlobalVariables.googleSignin),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': user?.displayName,
        'email': user?.email,
        'google_id': user?.id,
        'profile_picture': user?.photoUrl,
        'notification_token': notificationToken
      }),
       );
    if(response.statusCode == 200){
      final responseData = jsonDecode(response.body);
      prefs.setString('isLoginGoogle','true');
      prefs.setString('user_id','${responseData['user']['id']}');
      prefs.setString('token','${responseData['token']}');
      Get.offAllNamed(Routes.BOTTOM_NAVBAR);
    }
      if (user == null) {
        Get.snackbar('Error', 'Sign In Failed');
      } else {
        Get.snackbar('Pesan', 'Success');

      }
    } on PlatformException catch (e) {
      Get.snackbar('Error', 'Sign In Failed - $e');
    } catch (e) {
      Get.snackbar('Error', 'Sign In Failed - $e');
    }finally{
      loginController.isLoading.value = false;
    }
  }
}
