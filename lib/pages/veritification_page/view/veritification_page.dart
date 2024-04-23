import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/register_page/controller/register_controller.dart';
import 'package:warmindo_user_ui/pages/veritification_page/controller/veritification_controller.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/otp_textfield.dart';

import '../../../utils/themes/color_themes.dart';

class VerificationPage extends GetView<VeritificationController> {
  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.offNamed(Routes.REGISTER_PAGE);
          },
        ),
      ),
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
              RichText(
                textAlign: TextAlign.start, // Align text to center
                text: TextSpan(
                  style: subheaderverifyTextStyle,
                  children: <TextSpan>[
                    TextSpan(
                      text:
                      'Masukkan kode verifikasi yang telah kami kirimkan ke nomor telepon kamu ',
                    ),
                    TextSpan(
                      text: '${registerController.ctrPhone2.value}',
                      style: boldphoneNumberTextStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  VerificationCodeInput(
                      key: UniqueKey(), controller: controller.code1Controller, index: 1),
                  SizedBox(width: 17),
                  VerificationCodeInput(
                      key: UniqueKey(), controller: controller.code2Controller, index: 2),
                  SizedBox(width: 17),
                  VerificationCodeInput(
                      key: UniqueKey(), controller: controller.code3Controller, index: 3),
                  SizedBox(width: 17),
                  VerificationCodeInput(
                      key: UniqueKey(), controller: controller.code4Controller, index: 4),
                ],
              ),
              SizedBox(height: 25),
              Obx(() {
                print('isFilled value: ${controller.isFilled.value}');
                return Container(
                  width: 350,
                  height: 50,
                  decoration: BoxDecoration(
                    color: (controller.isFilled.value) ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      print('Verification code: ${controller.code1Controller.text}${controller.code2Controller.text}${controller.code3Controller.text}${controller.code4Controller.text}');
                    },
                    child: Center(
                      child: Text(
                        'SUBMIT',
                        style: whiteboldTextStyle,
                      ),
                    ),
                  ),
                );
              }),


              SizedBox(height: 20.0),
              // Button to resend the verification code
              TextButton(
                onPressed: () {
                  // Add logic to resend the code
                  print('Resend code');
                },
                child: Text('Resend code', style: bluelinkTextStyle,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
