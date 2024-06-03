import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

class VerificationCodeInput extends StatelessWidget {
  final TextEditingController controller;
  final int index;

  const VerificationCodeInput({
    required this.controller,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.11,
      height: screenWidth * 0.11,
      child: Center(
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          maxLength: 1,
          textAlign: TextAlign.center,
          onChanged: (String value) {
            if (value.length == 1) {
              if (index == 6) {
                FocusScope.of(context).unfocus();
              } else {
                FocusScope.of(context).nextFocus();
              }
            }
          },
          decoration: InputDecoration(
            counterText: '',
            contentPadding: EdgeInsets.zero, // Ensures no extra padding
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          style:otpcode,
        ),
      ),
    );
  }
}
