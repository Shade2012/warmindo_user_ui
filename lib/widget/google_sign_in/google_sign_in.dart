import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import '../../pages/home_page/view/home_page.dart';
import '../../utils/themes/image_themes.dart';


class GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        signIn(context);
      },
      child: Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        padding: EdgeInsets.all(5),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 3, // Spread radius
              blurRadius: 3, // Blur radius
              offset: Offset(0, 3), // Offset
            ),
          ],
        ),
          child: Image.asset(Images.google),
      ),
    );
  }

  void signIn(BuildContext context) async {
    try {
      //sementara ada signout disini dulu
      await GoogleSignIn().signOut();
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
