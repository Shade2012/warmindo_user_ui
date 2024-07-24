import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

import '../../../utils/themes/buttonstyle_themes.dart';
import '../../../widget/otp_textfield.dart';
import '../controller/verification_profile_controller.dart';
class PopUpVerification extends StatelessWidget {
  final VerificationProfileController controller = Get.find();


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white, // Background color
      contentPadding: EdgeInsets.all(10),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Text('Verifikasi Nomor Hp',style: boldTextStyle,),
              SizedBox(height: 10,),
              Text('Tolong isi kolom ini dengan kode otp yang kami kirimkan melalui WA anda',style: onboardingskip,),
              SizedBox(height: 10,),
              Container(
                width: screenWidth * 0.9,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      VerificationCodeInput(
                          key: ValueKey("code7"), controller: controller.code7Controller, index: 1),
                      VerificationCodeInput(
                          key: ValueKey("code8"), controller: controller.code8Controller, index: 2),
                      VerificationCodeInput(
                          key: ValueKey("code9"), controller: controller.code9Controller, index: 3),
                      VerificationCodeInput(
                          key: ValueKey("code10"), controller: controller.code10Controller, index: 4),
                      VerificationCodeInput(
                          key: ValueKey("code11"), controller: controller.code11Controller, index: 5),
                      VerificationCodeInput(
                          key: ValueKey("code12"), controller: controller.code12Controller, index: 6),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: Container(
                    width:screenWidth,
                    child: ElevatedButton(onPressed: (){
                      if(controller.isFilled.value == true){
                        controller.confirmEditPhone();
                        print('Verification code: ${controller.codeOtp.value}');
                      }else{
                        return;
                      }
                    },style: verifyOTPStyle(controller.isFilled.value), child: Text('Verifikasi',style: whiteboldTextStyle15,))) ,
              )
            ],
          ),
        ),
      ),
    );
  }
}
