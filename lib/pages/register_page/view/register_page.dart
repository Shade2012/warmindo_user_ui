import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:warmindo_user_ui/pages/register_page/controller/register_controller.dart';
import 'package:warmindo_user_ui/widget/inputfield.dart';
import 'package:get/get.dart';
import '../../../routes/AppPages.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../utils/themes/color_themes.dart';
import '../../../utils/themes/image_themes.dart';



class RegisterPage extends GetView<RegisterController>{
  final TextEditingController ctrName = TextEditingController();
  final TextEditingController ctrUsername = TextEditingController();
  final TextEditingController ctrEmail = TextEditingController();
  final TextEditingController ctrNumberPhone = TextEditingController();
  final TextEditingController ctrPassword = TextEditingController();
   RegisterPage({super.key});


  String? isEmailValid(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!value.contains('@')) {
      return 'Invalid email';
    }
    return null;
  }
  String? isPhone(String value) {
    if (value.isEmpty) {
      return 'Phone Number is required';
    }
    return null;
  }
  String? isNama(String value) {
    if (value.isEmpty) {
      return 'Nama Lengkap is required';
    }
    return null;
  }
  String? isUsername(String value) {
    if (value.isEmpty) {
      return 'Username is required';
    }
    return null;
  }
  String? isPassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Minimum password length is 8 characters';
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
// Control the obscure text visibility

    return Container(
      margin: EdgeInsets.only(top: 20,bottom: 20),
      child: Obx(()=> TextField(
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20,top: 40),
                child: Center(
                    child: Text("Daftar",style: onboardingHeaderTextStyle ,)
                ),
              ),
              Center(
                  child: Text("Silakan Daftar dibawah sini",style: regularTextStyle ,)
              ),
              myText(Icons.person_2_outlined, TextInputType.text,"Nama Lengkap", "Isi Nama Aslimu", ctrName,null),
              myText(Icons.person_2_outlined,TextInputType.text, "Username", "Isi Username mu", ctrUsername,null),
              myText(Icons.mail_outline, TextInputType.emailAddress, "Email", "Isi Emailmu", ctrEmail, isEmailValid),
              myText(Icons.phone, TextInputType.phone,"Nomor Telepon", "Isi Nomor Hpmu", ctrNumberPhone,isPhone),
              Password(Icons.lock_outline, "Password", "Isi Password mu", ctrPassword,isPassword),
              GestureDetector(
                onTap: () {
                  if (isEmailValid(ctrEmail.text) == null &&
                      isPassword(ctrPassword.text) == null &&
                      isPhone(ctrNumberPhone.text) == null &&
                      isNama(ctrName.text) == null &&
                      isUsername(ctrUsername.text) == null) {
                    // All fields are valid, perform registration logic

                  }
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (isEmailValid(ctrEmail.text) == null &&
                        isPassword(ctrPassword.text) == null &&
                        isPhone(ctrNumberPhone.text) == null &&
                        isNama(ctrName.text) == null &&
                        isUsername(ctrUsername.text) == null)
                        ? ColorResources.btnonboard
                        : Colors.grey,
                  ),
                  width: screenWidth,
                  height: 50,
                  child: Center(child: Text("Register", style: whiteboldTextStyle)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20,bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sudah punya akun? "),
                    GestureDetector(
                      onTap: (){

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
              SizedBox(width: 10),
              Text(
                'Atau Daftar',
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
              Container(
                margin: EdgeInsets.only(top: 40,bottom: 20),
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
                padding: EdgeInsets.all(5),
                height: 60,
                child: Image.asset(Images.google),
              )
            ],
          ),
        ),
      )
    );
  }
}
