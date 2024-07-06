import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import '../../pages/home_page/view/home_page.dart';


class GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        signIn(context);
      },
      child: Text('Sign in with Google'),
    );
  }

  void signIn(BuildContext context) async {

    try {
      final user = await GoogleSignIn().signIn();
    // final response = await http.get(
    //   Uri.parse('http://warmindo.pradiptaahmad.tech/api/auth/google'),
    //    );
      if (user == null) {
        Get.snackbar('Error', 'Sign In Failed');
      } else {
        Get.snackbar('Pesan', 'Success');
        print(user);
      }
    } on PlatformException catch (e) {
      print('Error signing in with Google: $e');
      Get.snackbar('Error', 'Sign In Failed - PlatformException');
    } catch (e) {
      print('Error signing in with Google: $e');
      Get.snackbar('Error', 'Sign In Failed - General Exception');
    }
  }
}
