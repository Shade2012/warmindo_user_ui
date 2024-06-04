import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/login_page/controller/login_controller.dart';
import 'package:warmindo_user_ui/pages/register_page/controller/register_controller.dart';
import 'package:warmindo_user_ui/pages/veritification_page/controller/veritification_controller.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/otp_textfield.dart';

import '../../../utils/themes/buttonstyle_themes.dart';
import '../../../utils/themes/color_themes.dart';

class VerificationPage extends GetView<VeritificationController> {
  final RegisterController registerController = Get.put(RegisterController());
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.center, // Set cross axis alignment to center
                children: <Widget>[
                  SizedBox(height: 30), // Add some spacing
                  Text(
                    'Masukkan Kode Verifikasi',
                    style: headerboldverifyTextStyle,
                    textAlign: TextAlign.start, // Align text to center
                  ),
                  SizedBox(height: 10),
                  Visibility(
                    visible: loginController.phone_number.value != "",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: subheaderverifyTextStyle, // Base style for the whole text
                            children: [
                              TextSpan(
                                text: 'Masukkan kode verifikasi yang telah kami kirimkan ke nomor telepon kamu ',
                              ),
                              TextSpan(
                                text: '+62 ${controller.removeLeadingZero(loginController.phone_number.value)}',
                                style: boldphoneNumberTextStyle,
                              ),

                            ],
                          ),
                        ),
                        TextButton(onPressed: (){}, child: Text('Edit',style: blueLinkRegular,))
                      ],
                    ),
                  ),
                  Visibility(
                    visible: registerController.phone_number.value != "",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: subheaderverifyTextStyle, // Base style for the whole text
                            children: [
                              TextSpan(
                                text: 'Masukkan kode verifikasi yang telah kami kirimkan ke nomor telepon kamu ',
                              ),
                              TextSpan(
                                text: '+62 ${controller.removeLeadingZero(registerController.phone_number.value)}',
                                style: boldphoneNumberTextStyle,
                              ),
                            ],
                          ),
                        ),
                        TextButton(onPressed: (){}, child: Text('Edit',style: blueLinkRegular,))
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      VerificationCodeInput(
                          key: UniqueKey(), controller: controller.code1Controller, index: 1),
                      VerificationCodeInput(
                          key: UniqueKey(), controller: controller.code2Controller, index: 2),
                      VerificationCodeInput(
                          key: UniqueKey(), controller: controller.code3Controller, index: 3),
                      VerificationCodeInput(
                          key: UniqueKey(), controller: controller.code4Controller, index: 4),
                      VerificationCodeInput(
                          key: UniqueKey(), controller: controller.code5Controller, index: 5),
                      VerificationCodeInput(
                          key: UniqueKey(), controller: controller.code6Controller, index: 6),
                    ],
                  ),
                  SizedBox(height: 25),
                  Obx(() {
                    return Container(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: (){
                        if(controller.isFilled.value == true){
                          controller.verifyOtp();
                          print('Verification code: ${controller.codeOtp.value}');
                        }else{
                          return;
                        }
                      }, style:verifyOTPStyle(controller.isFilled.value) ,child: Text("SUBMIT",style: whiteboldTextStyle)),
                    );
                  }),

                  SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () {
                      controller.sendOtp();
                      print('Resend code');
                    },
                    child: Text('Resend code', style: bluelinkTextStyle,),
                  ),
                  // ElevatedButton(onPressed: (){
                  //   print('${controller.codeOtp.value}');
                  //
                  // }, child: Text('test'))
                ],
              ),
            ),
          ),
        ),
        Obx(() {
          if (controller.isLoading.value == true) {
            return Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator( color: Colors.blue,),
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
