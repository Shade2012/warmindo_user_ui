import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import '../../../utils/themes/buttonstyle_themes.dart';
import '../../../widget/otp_textfield.dart';
import '../controller/verification_profile_controller.dart';
class PopUpVerification extends StatelessWidget {
  final VerificationProfileController controller = Get.find();

  PopUpVerification({super.key});


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white, // Background color
      contentPadding: const EdgeInsets.all(10),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text('Verifikasi Nomor Hp',style: boldTextStyle,),
            const SizedBox(height: 10,),
            Text('Tolong isi kolom ini dengan kode otp yang kami kirimkan melalui WA anda',style: onboardingskip,),
            const SizedBox(height: 10,),
            SizedBox(
              width: screenWidth * 0.9,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VerificationCodeInput(
                        key: const ValueKey("code7"), controller: controller.code7Controller, index: 1),
                    VerificationCodeInput(
                        key: const ValueKey("code8"), controller: controller.code8Controller, index: 2),
                    VerificationCodeInput(
                        key: const ValueKey("code9"), controller: controller.code9Controller, index: 3),
                    VerificationCodeInput(
                        key: const ValueKey("code10"), controller: controller.code10Controller, index: 4),
                    VerificationCodeInput(
                        key: const ValueKey("code11"), controller: controller.code11Controller, index: 5),
                    VerificationCodeInput(
                        key: const ValueKey("code12"), controller: controller.code12Controller, index: 6),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Center(
              child: SizedBox(
                  width:screenWidth,
                  child: ElevatedButton(onPressed: (){
                    if(controller.isFilled.value == true){
                      controller.confirmEditPhone();
                      print('Verification code: ${controller.codeOtp.value}');
                    }else{
                      return;
                    }
                  },style: verifyOTPStyle(controller.isFilled.value), child: Text('Verifikasi',style: whiteboldTextStyle15,))) ,
            ),
            const SizedBox(height: 10,),
            Center(
              child: InkWell(onTap: (){
                if(controller.isFilled.value == true){
                  controller.sendOtp();
                  print('Verification code: ${controller.codeOtp.value}');
                }else{
                  return;
                }
              }, child: Text('Kirim Ulang',style: blueLinkRegular,)) ,
            )
          ],
        ),
      ),
    );
  }
}
