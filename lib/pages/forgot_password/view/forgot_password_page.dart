import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/pages/forgot_password/controller/forgot_password_controller.dart';
import 'package:warmindo_user_ui/pages/forgot_password/view/forgot_password_page_second.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:get/get.dart';
import '../../../utils/themes/buttonstyle_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/appBar.dart';
class ForgotPasswordPage extends StatelessWidget {
  final ForgotPasswordController controller = Get.put(ForgotPasswordController());
   ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(title: 'Lupa Password',style: headerRegularStyle,),
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
              Text('Silahkan Isi Nomor HP anda yang sudah terdaftar di akun kami',style: boldTextStyle,),
              const SizedBox(height: 10.0),
              Text("Nomor HP",style: regularInputTextStyle,),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: controller.phoneNumberController,style: regularInputTextStyle,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0), // Adjust padding here
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                validator: (value) {
                  if(value!.length < 9){
                    return 'Nomor Hp tidak valid';
                  }
                  return null ;
                },

              ),
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
}
