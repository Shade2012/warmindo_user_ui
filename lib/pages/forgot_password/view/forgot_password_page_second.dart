import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/pages/forgot_password/controller/forgot_password_controller.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:get/get.dart';
import '../../../utils/themes/buttonstyle_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/appBar.dart';
import '../../../widget/otp_textfield.dart';
class ForgotPasswordSecondPage extends StatelessWidget {
  final ForgotPasswordController controller = Get.put(ForgotPasswordController());
  ForgotPasswordSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(title: 'Verifikasi Nomor Hp mu',style: headerRegularStyle,),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
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
                        key: const ValueKey("code13"), controller: controller.code13Controller, index: 1),
                    VerificationCodeInput(
                        key: const ValueKey("code14"), controller: controller.code14Controller, index: 2),
                    VerificationCodeInput(
                        key: const ValueKey("code15"), controller: controller.code15Controller, index: 3),
                    VerificationCodeInput(
                        key: const ValueKey("code16"), controller: controller.code16Controller, index: 4),
                    VerificationCodeInput(
                        key: const ValueKey("code17"), controller: controller.code17Controller, index: 5),
                    VerificationCodeInput(
                        key: const ValueKey("code18"), controller: controller.code18Controller, index: 6),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                child: Obx(()=> ElevatedButton(onPressed: (){
                    if(controller.isFilled.value == true){
                    controller.verifyOtp();
                    }else{
                      return;
                    }
                  }, style: verifyOTPStyle(controller.isFilled.value),  child:controller.isLoading.value ? const SizedBox(
                  width: 24,
                  height: 24,
                    child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                                    ),
                  ) : Text('Verifikasi', style: whiteboldTextStyle15),),
                ),
              ),
              const SizedBox(height: 20.0),
              InkWell(
                onTap: (){
                  controller.sendOtpWithoutPhoneNumber();
                },
                  child: Center(child: Text('Resend code',style: bluelinkTextStyle,),))
            ],
          ),
        ),
      ),
    );
  }
}
