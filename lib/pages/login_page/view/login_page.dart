import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:warmindo_user_ui/pages/login_page/controller/login_controller.dart';
import 'package:warmindo_user_ui/widget/inputfield.dart';
import 'package:get/get.dart';
import '../../../routes/AppPages.dart';
import '../../../utils/themes/buttonstyle_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../utils/themes/color_themes.dart';
import '../../../utils/themes/image_themes.dart';
import '../../../widget/google_sign_in/google_sign_in.dart';

class LoginPage extends GetView<LoginController> {
  final TextEditingController ctrUsername = TextEditingController();
  final TextEditingController ctrPassword = TextEditingController();
  LoginPage({super.key});
  String? isPassword(String value) {
    if (value.isEmpty) {
      return null;
    } else if (value.length < 8) {
      return 'Minimal password 8 karakter';
    }
    return null;
  }

  Widget Password(
    IconData icon,
    String label,
    String hint,
    TextEditingController controller2,
    String? Function(String)? validator,
  ) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Obx(
        () => TextField(
          controller: controller2,
          obscureText: controller.obscureText.value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                controller.obscureText.value = !controller.obscureText.value;
              },
              icon: Icon(controller.obscureText.value
                  ? Icons.visibility
                  : Icons.visibility_off),
            ),
            // suffixIcon: ),
            hintText: hint,
            labelText: label,
            prefixIcon: Icon(icon),
            labelStyle: boldTextStyle,
            hintStyle: TextStyle(
              color: primaryTextColor,
              fontSize: 12,
            ),
            errorText: validator != null ? validator(controller2.text) : null,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
            body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight / 10,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, top: 40),
                  child: Center(
                      child: Text(
                    "Hello",
                    style: onboardingHeaderTextStyle,
                  )),
                ),
                Center(
                    child: Text(
                  "Selamat datang, kamu",
                  style: regularTextStyle,
                )),
                SizedBox(
                  height: screenHeight / 8,
                ),
                myText(Icons.person_2_outlined, TextInputType.text, "Username",
                    "Isi Username mu", ctrUsername, null),
                Password(Icons.lock_outline, "Password", "Isi Password mu",
                    ctrPassword, isPassword),
                Center(
                    child: InkWell(
                      onTap: (){
                        Get.toNamed(Routes.FORGOT_PASSWORD_PAGE);
                      },
                        child: Text('Lupa Password',style: boldTextStyle,))),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (ctrPassword.text.isNotEmpty &&
                            ctrUsername.text.isNotEmpty &&
                            isPassword(ctrPassword.text) == null) {
                          controller.loginUser(ctrUsername.text, ctrPassword.text);
                        } else {
                          Get.snackbar("Warning",
                              'Tolong isi semua data terlebih dahulu');
                        }
                      },
                      style: authLoginRegisterButtonStyle(),
                      child: Text(
                        'Login',
                        style: whiteboldTextStyle,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Tidak punya akun? "),
                      GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.REGISTER_PAGE);
                          },
                          child: Text(
                            "Daftar Sekarang ",
                            style: LoginboldTextStyle,
                          )),
                    ],
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 2,
                        width: 50,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Atau Daftar Lewat',
                        style: boldTextStyle,
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 2,
                        width: 50,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                GoogleSignInButton()
              ],
            ),
          ),
        )),
        Obx(() {
          if (controller.isLoading.value == true) {
            return Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        }),
      ],
    );
  }
}
