import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/register_page/controller/register_controller.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/otp_textfield.dart';

class VerificationPage extends StatelessWidget {
  final RegisterController registerController = Get.put(RegisterController());
  final _codeController1 = TextEditingController();
  final _codeController2 = TextEditingController();
  final _codeController3 = TextEditingController();
  final _codeController4 = TextEditingController();

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
                      key: UniqueKey(), controller: _codeController1, index: 1),
                  SizedBox(width: 17),
                  VerificationCodeInput(
                      key: UniqueKey(), controller: _codeController2, index: 2),
                  SizedBox(width: 17),
                  VerificationCodeInput(
                      key: UniqueKey(), controller: _codeController3, index: 3),
                  SizedBox(width: 17),
                  VerificationCodeInput(
                      key: UniqueKey(), controller: _codeController4, index: 4),
                ],
              ),
              SizedBox(height: 25),
              Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue, // Warna latar belakang
                  borderRadius: BorderRadius.circular(8), // Border radius
                ),
                child: GestureDetector(
                  onTap: () {
                    print('Verification code: ${_codeController1.text}${_codeController2.text}${_codeController3.text}${_codeController4.text}');
                  },
                  child: Center(
                    child: Text(
                      'SUBMIT',
                      style: whiteboldTextStyle
                    ),
                  ),
                ),
              ),

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
