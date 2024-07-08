import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/pages/forgot_password/controller/forgot_password_controller.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:get/get.dart';
import '../../../utils/themes/buttonstyle_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/appBar.dart';
import '../../../widget/otp_textfield.dart';
import 'forgot_password_last_page.dart';
class ForgotPasswordSecondPage extends StatelessWidget {
  final ForgotPasswordController controller = Get.put(ForgotPasswordController());
  ForgotPasswordSecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(title: 'Verifikasi Nomor Hp mu',style: headerRegularStyle,),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 400,
                height: 300,
                child: Image.asset(Images.forgot_password_2,fit: BoxFit.cover,),
              ),
              Text('Silahkan Isi Kode Otp yang sudah kami kirimkan ke no wa HP anda',style: boldTextStyle,),
              const SizedBox(height: 10.0),
              Text("Kode OTP",style: regularInputTextStyle,),
              const SizedBox(height: 10.0),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VerificationCodeInput(
                        key: ValueKey("code13"), controller: controller.code13Controller, index: 1),
                    VerificationCodeInput(
                        key: ValueKey("code14"), controller: controller.code14Controller, index: 2),
                    VerificationCodeInput(
                        key: ValueKey("code15"), controller: controller.code15Controller, index: 3),
                    VerificationCodeInput(
                        key: ValueKey("code16"), controller: controller.code16Controller, index: 4),
                    VerificationCodeInput(
                        key: ValueKey("code17"), controller: controller.code17Controller, index: 5),
                    VerificationCodeInput(
                        key: ValueKey("code18"), controller: controller.code18Controller, index: 6),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                child: ElevatedButton(onPressed: (){
                  //
                  print('code : ${controller.codeOtp}');
                  Get.to(ForgotPasswordLastPage());
                }, style: editPhoneNumber(),child: Text('Verifikasi',style: whiteboldTextStyle15,)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
