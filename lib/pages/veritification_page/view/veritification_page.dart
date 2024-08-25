import 'package:flutter/material.dart';
import 'package:get/get.dart';
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


class VerificationPage extends GetView<VeritificationController> {
  final RegisterController registerController = Get.put(RegisterController());
  final LoginController loginController = Get.put(LoginController());
  final CartController cartController = Get.put(CartController());
  final RxBool isLogged;
  VerificationPage({super.key, required this.isLogged});
  @override
  Widget build(BuildContext context) {
  final double screenHeight =  MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    InkWell(
                      child: Ink(
                          child: const Icon(Icons.arrow_back_ios_new)),
                      onTap: (){
                        Get.back();
                      },
                    ),
                    SizedBox(height: screenHeight * 0.26,),
                    Column(
                      children: [
                        Text(
                          'Masukkan Kode Verifikasi',
                          style: headerboldverifyTextStyle,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 10,),
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
                                                    return EditPopup(phone_number: loginController.phone_number.value);
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

                        const SizedBox(height: 10,),
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
                                                  return EditPopup(phone_number: registerController.phone_number.value);
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
                    const SizedBox(height: 20,),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          VerificationCodeInput(
                              key: const ValueKey("code1"), controller: controller.code1Controller, index: 1),
                          VerificationCodeInput(
                              key: const ValueKey("code2"), controller: controller.code2Controller, index: 2),
                          VerificationCodeInput(
                              key: const ValueKey("code3"), controller: controller.code3Controller, index: 3),
                          VerificationCodeInput(
                              key: const ValueKey("code4"), controller: controller.code4Controller, index: 4),
                          VerificationCodeInput(
                              key: const ValueKey("code5"), controller: controller.code5Controller, index: 5),
                          VerificationCodeInput(
                              key: const ValueKey("code6"), controller: controller.code6Controller, index: 6),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Column(
                      children: [
                        Obx(() {
                          return SizedBox(
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
                        const SizedBox(height: 20.0),
                        TextButton(
                          onPressed: () {
                            controller.sendOtp();
                            print('Resend code');
                          },
                          child: Text('Kirim Ulang', style: bluelinkTextStyle,),
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
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ],
    );
  }
}
