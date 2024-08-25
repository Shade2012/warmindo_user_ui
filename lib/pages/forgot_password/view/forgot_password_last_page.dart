import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/pages/forgot_password/controller/forgot_password_controller.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:get/get.dart';
import '../../../utils/themes/buttonstyle_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/appBar.dart';
class ForgotPasswordLastPage extends StatelessWidget {
  final ForgotPasswordController controller = Get.put(ForgotPasswordController());
  ForgotPasswordLastPage({super.key});

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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 400,
                height: 300,
                child: Image.asset(Images.forgot_password_1,fit: BoxFit.cover,),
              ),
              Text('Password disarankan berbeda dengan password lama',style: regularTextStyle,),
              const SizedBox(height: 20.0),
              Password(Icons.lock_outline, "Password Baru",controller.newPassword, false.obs, isPassword),
              const SizedBox(height: 20.0),
              Password(Icons.lock_outline, "Konfirmasi Password", controller.confirmPassword, false.obs, isPassword),
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                child: Obx(()=> ElevatedButton(onPressed: (){
                    if(controller.newPassword.text != controller.confirmPassword.text){
                      Get.snackbar(
                        'Pesan',
                        'Password tidak sama',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }else{
                      controller.forgotPassword(newPassword: controller.newPassword.text,confirmPassword: controller.confirmPassword.text);
                    }
                  }, style: editPhoneNumber(), child:controller.isLoading.value ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                ) : Text('Konfirmasi', style: whiteboldTextStyle15),),
                ),
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
      TextEditingController controller2,
      RxBool obscureText,
      String? Function(String)? validator,
      ) {
    return Obx(()=> TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller2,
      obscureText: obscureText.value,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        suffixIcon: IconButton(onPressed: (){
          obscureText.value =! obscureText.value;
        },
          icon: Icon( obscureText.value?Icons.visibility:Icons.visibility_off),color: Colors.black,),
        // suffixIcon: ),
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
    );
  }

}
