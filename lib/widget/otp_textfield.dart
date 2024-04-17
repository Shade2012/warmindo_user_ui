import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

class VerificationCodeInput extends StatelessWidget {
  final TextEditingController controller;
  final int index;

  const VerificationCodeInput({
    required this.controller,
    required this.index,
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 73,
      height: 73,
      child: Align(
        alignment: Alignment.center,
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          maxLength: 1,
          textAlign: TextAlign.center,
          onChanged: (String value) {
            if (value.length == 1) {
              if (index == 4) {
                FocusScope.of(context).unfocus();
              } else {
                FocusScope.of(context).nextFocus();
              }
            }
          },
          decoration: InputDecoration(
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          style: boldcodeTextStyle,
        ),
      ),
    );
  }
}
