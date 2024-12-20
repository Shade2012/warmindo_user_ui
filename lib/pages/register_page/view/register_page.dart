import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/pages/register_page/controller/register_controller.dart';
import 'package:warmindo_user_ui/utils/themes/buttonstyle_themes.dart';
import 'package:warmindo_user_ui/widget/inputfield.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/widget/reusable_dialog.dart';
import '../../../routes/AppPages.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/google_sign_in/google_sign_in.dart';
import '../../login_page/controller/login_controller.dart';



class RegisterPage extends GetView<RegisterController>{
  final LoginController loginController = Get.put(LoginController());
  final TextEditingController ctrName = TextEditingController();
  final TextEditingController ctrUsername = TextEditingController();
  final TextEditingController ctrEmail = TextEditingController();
  final TextEditingController ctrNumberPhone = TextEditingController();
  final TextEditingController ctrPassword = TextEditingController();
   RegisterPage({super.key});


  String? isEmailValid(String value) {
    if (value.length == 0) {
      return null;
    }
     if (!value.contains('@')) {
      return 'Email tidak valid';
    }
    return null;
  }
  String? isPhone(String value) {
    if (value.length == 0) {
      return null;
    }
    if(value.length < 9){
      return 'Nomor Hp tidak valid';
    }

    return null;
  }

  String? isPassword(String value) {
    if(value.length == 0){
      return null;
    }
      if (value.length < 8) {
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
      margin: const EdgeInsets.only(top: 20,bottom: 20),
      child: Obx(()=> TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller2,
        obscureText: controller.obscureText.value,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: IconButton(onPressed: (){
            controller.obscureText.value =!controller.obscureText.value;
          },
            icon: Icon(controller.obscureText.value?Icons.visibility:Icons.visibility_off),),
          // suffixIcon: ),
          hintText: hint,
          labelText: label,
          prefixIcon: Icon(icon),
          labelStyle: bold14,
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
                margin: const EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20,top: 40),
                      child: Center(
                          child: Text("Daftar",style: onboardingHeaderTextStyle ,)
                      ),
                    ),
                    Center(
                        child: Text("Silakan Daftar dibawah sini",style: regularTextStyle ,)
                    ),
                    myText(Icons.person_2_outlined, TextInputType.text,"Nama Lengkap", "Ex: ex@gmail.com", ctrName,null),
                    myText(Icons.person_2_outlined,TextInputType.text, "Username", "Ex: userTest", ctrUsername,null),
                    myText(Icons.mail_outline, TextInputType.emailAddress, "Email", "Ex: ex@gmail.com", ctrEmail, isEmailValid),
                    myText(Icons.phone, TextInputType.phone,"Nomor Telepon", "Ex: 082124805253", ctrNumberPhone,isPhone),
                    Password(Icons.lock_outline, "Password", "Ex: ********", ctrPassword,isPassword),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isEmailValid(ctrEmail.text) == null &&
                              ctrEmail.text.isNotEmpty &&
                              ctrNumberPhone.text.isNotEmpty &&
                              ctrPassword.text.isNotEmpty &&
                              ctrName.text.isNotEmpty &&
                              ctrUsername.text.isNotEmpty &&
                              isPassword(ctrPassword.text) == null &&
                              isPhone(ctrNumberPhone.text) == null) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ReusableDialog(
                                  title: 'Warning',
                                  content: 'Apakah anda yakin data yang anda inputkan sudah sesuai?',
                                  cancelText: "Tidak",
                                  confirmText: "Iya",
                                  onCancelPressed: () {
                                    Get.back();
                                  },
                                  onConfirmPressed: () {
                                    loginController.phone_number.value = '';
                                    Get.back();
                                    controller.ctrPhone2.value = ctrNumberPhone.text;
                                    controller.registerUser(
                                      ctrName.text,
                                      ctrUsername.text,
                                      ctrNumberPhone.text,
                                      ctrEmail.text,
                                      ctrPassword.text,
                                    );
                                  },
                                );
                              },
                            );
                          } else {
                            Get.snackbar("Warning", 'Tolong isi semua data terlebih dahulu');
                          }
                        },
                        style: authLoginRegisterButtonStyle(),
                        child: Text('Register', style: whiteboldTextStyle),
                      ),

                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20,bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Sudah punya akun? "),
                          GestureDetector(
                              onTap: (){
                                Get.toNamed(Routes.LOGIN_PAGE);
                              },
                              child: Text("Login Sekarang ",style:LoginboldTextStyle,)),
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
                          const SizedBox(width: 10),
                          Text(
                            'Atau Daftar',
                            style: boldTextStyle,
                          ),
                          const SizedBox(width: 10),
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
            )
        ),
        Obx(() {
          if (controller.isLoading.value == true) {
            return Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator( color: Colors.black,),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ],
    );

  }
}

