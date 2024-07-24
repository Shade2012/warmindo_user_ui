import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:warmindo_user_ui/pages/cart_page/controller/cart_controller.dart';
import 'package:warmindo_user_ui/pages/login_page/controller/login_controller.dart';
import 'package:warmindo_user_ui/pages/register_page/controller/register_controller.dart';
import 'package:warmindo_user_ui/pages/veritification_page/controller/veritification_controller.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/editPopup.dart';
import 'package:warmindo_user_ui/widget/otp_textfield.dart';
import 'package:flutter/gestures.dart';
import '../../../utils/themes/buttonstyle_themes.dart';
import '../../../utils/themes/color_themes.dart';

class VerificationPage extends GetView<VeritificationController> {

  final RegisterController registerController = Get.put(RegisterController());
  final LoginController loginController = Get.put(LoginController());
  final CartController cartController = Get.find<CartController>();
  final RxBool isLogged;
  VerificationPage({required this.isLogged});
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,  // Ensure the container takes full screen height
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Masukkan Kode Verifikasi',
                          style: headerboldverifyTextStyle,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 10,),
                     Visibility(
                            visible: loginController.phone_number.value != "",
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(()=> RichText(
                                    text: TextSpan(
                                      style: subheaderverifyTextStyle,
                                      children: [
                                        TextSpan(
                                            text: 'Masukkan kode verifikasi yang telah kami kirimkan ke nomor telepon kamu ',
                                            style: subheaderverifyTextStyle
                                        ),
                                        TextSpan(
                                          text: '+62 ${controller.removeLeadingZero(loginController.phone_number.value)}',
                                          style: boldphoneNumberTextStyle,
                                        ),
                                        TextSpan(
                                            text: ' Edit ',
                                            style: blueLinkRegular,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return EditPopup(phone_number: '${loginController.phone_number.value}');
                                                  },
                                                );
                                              }),
                                      ],
                                    ),
                                  ),
                                ),
                                // InkWell(
                                //   onTap: (){},
                                //   child: Text('Edit',style: blueLinkRegular,),
                                // )
                              ],
                            ),
                          ),

                        SizedBox(height: 10,),
                        Obx(() => Visibility(
                            visible: registerController.phone_number.value != "",
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: subheaderverifyTextStyle,
                                    children: [
                                      TextSpan(
                                          text: 'Masukkan kode verifikasi yang telah kami kirimkan ke nomor telepon kamu ',
                                          style: subheaderverifyTextStyle
                                      ),
                                      TextSpan(
                                        text: '+62 ${controller.removeLeadingZero(registerController.phone_number.value)} ',
                                        style: boldphoneNumberTextStyle,
                                      ),
                                      TextSpan(
                                          text: ' Edit',
                                          style: blueLinkRegular,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return EditPopup(phone_number: '${registerController.phone_number.value}');
                                                },
                                              );
                                            }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          VerificationCodeInput(
                              key: ValueKey("code1"), controller: controller.code1Controller, index: 1),
                          VerificationCodeInput(
                              key: ValueKey("code2"), controller: controller.code2Controller, index: 2),
                          VerificationCodeInput(
                              key: ValueKey("code3"), controller: controller.code3Controller, index: 3),
                          VerificationCodeInput(
                              key: ValueKey("code4"), controller: controller.code4Controller, index: 4),
                          VerificationCodeInput(
                              key: ValueKey("code5"), controller: controller.code5Controller, index: 5),
                          VerificationCodeInput(
                              key: ValueKey("code6"), controller: controller.code6Controller, index: 6),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Column(
                      children: [
                        Obx(() {
                          return Container(
                            width: double.infinity,
                            child: ElevatedButton(onPressed:  ()async{
                              if(controller.isFilled.value == true){
                              await controller.verifyOtp();
                                if(controller.isSuccess.value == 'success'){
                                  if(isLogged.value == false){
                                    Get.offNamed(Routes.LOGIN_PAGE);
                                  }else{
                                    await cartController.fetchUser();
                                    Get.offNamed(Routes.BOTTOM_NAVBAR);
                                  }
                                }

                                print('Verification code: ${controller.codeOtp.value}');
                              }else{
                                return;
                              }
                            }, style: verifyOTPStyle(controller.isFilled.value), child: Text("SUBMIT", style: whiteboldTextStyle)),
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
                      ],
                    )
                  ],
                ),
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
                  child: CircularProgressIndicator(color: Colors.blue),
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
