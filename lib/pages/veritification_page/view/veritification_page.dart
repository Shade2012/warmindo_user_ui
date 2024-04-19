import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

import '../controller/veritification_controller.dart';

class VeritificationPage extends GetView<VeritificationController> {
  final TextEditingController pin1 = TextEditingController();
  final TextEditingController pin2 = TextEditingController();
  final TextEditingController pin3 = TextEditingController();
  final TextEditingController pin4 = TextEditingController();

   VeritificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(
        left: 20,
        top: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_rounded)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter Verification Code",
                style: HeadingVerification,
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(
                text: 'Masukkan Kode OTP yang kami kirim ke nomer hp anda ',
                style: regularInputTextStyle,
                children: <TextSpan>[
                  TextSpan(text: '+886953442834', style: boldTextStyle),
                ],
              )),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 68,
                    width: 68,
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorResources.uncheck,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: TextFormField(
                        controller: pin1,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        onSaved: (pin1) {},
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(

                              borderSide: BorderSide(color: ColorResources.focused,width: 2), // Change this to your desired color
                              borderRadius: BorderRadius.circular(10.0), // Match the container's radius
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        style: NumberStyle,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 68,
                    width: 68,
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorResources.uncheck,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: TextFormField(
                        controller: pin2,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        onSaved: (pin2) {},
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorResources.focused,width: 2), // Change this to your desired color
                              borderRadius: BorderRadius.circular(10.0), // Match the container's radius
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        style: NumberStyle,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 68,
                    width: 68,
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorResources.uncheck,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: TextFormField(
                        controller: pin3,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        onSaved: (pin3) {},
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(

                              borderSide: BorderSide(color: ColorResources.focused,width: 2), // Change this to your desired color
                              borderRadius: BorderRadius.circular(10.0), // Match the container's radius
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        style: NumberStyle,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 68,
                    width: 68,
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorResources.uncheck,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: TextFormField(
                        controller: pin4,
                        onSaved: (pin4) {},
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(

                              borderSide: BorderSide(color: ColorResources.focused,width: 2), // Change this to your desired color
                              borderRadius: BorderRadius.circular(10.0), // Match the container's radius
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        style: NumberStyle,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (pin1.text.isNotEmpty &&
                      pin2.text.isNotEmpty &&
                      pin3.text.isNotEmpty &&
                      pin4.text.isNotEmpty) {
                    // All fields are valid, perform registration logic

                  }
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20,left: 10,right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: (pin1.text.isNotEmpty &&
                        pin2.text.isNotEmpty &&
                        pin3.text.isNotEmpty &&
                        pin4.text.isNotEmpty)
                        ? ColorResources.focused
                        : Colors.grey,
                  ),
                  width: double.infinity,
                  height: 50,
                  child: Center(child: Text("SUBMIT", style: whiteboldTextStyle)),
                ),
              ),
              TextButton(onPressed: (){}, child: Text("Resend Code",style: link,))
            ],
          )
        ],
      ),
    ));
  }
}
