import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/pages/forgot_password/controller/forgot_password_controller.dart';
import 'package:warmindo_user_ui/pages/forgot_password/view/forgot_password_page_second.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:get/get.dart';
import '../../../utils/themes/buttonstyle_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/appBar.dart';
class ForgotPasswordLastPage extends StatelessWidget {
  final ForgotPasswordController controller = Get.put(ForgotPasswordController());
  ForgotPasswordLastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? isPassword(String value) {
      if (value.isEmpty) {
        return null;
      } else if (value.length < 8) {
        return 'Minimal password 8 karakter';
      }
      return null;
    }
    return Scaffold(
      appBar: AppbarCustom(title: 'Buat Password Baru',style: headerRegularStyle,),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 400,
                height: 300,
                child: Image.asset(Images.forgot_password_1,fit: BoxFit.cover,),
              ),
              Text('Password anda yang baru harus berbeda dengan password sebelum nya',style: boldTextStyle,),
              const SizedBox(height: 10.0),
              Text("Password",style: regularInputTextStyle,),
              const SizedBox(height: 10.0),
              Password(Icons.lock_outline, "Password Baru", "Isi Password mu",1 ,controller.newPassword, isPassword),
              Password(Icons.lock_outline, "Konfirmasi Password", "Isi Password mu", 2,controller.confirmPassword, isPassword),
              const SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                child: ElevatedButton(onPressed: (){
                  //
                  Get.to(ForgotPasswordSecondPage());
                }, style: editPhoneNumber(),child: Text('Kirim',style: whiteboldTextStyle15,)),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget Password(
      IconData icon,
      String label,
      String hint,
      int id,
      TextEditingController controller2,
      String? Function(String)? validator,
      ) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Obx(
            () => TextField(
          controller: controller2,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
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

}
