import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

Widget myTextFormField(
    TextInputType keyboardType,
    String label,
    TextEditingController controller,
    TextStyle style,
    int validatorID, // Validation function for email
    ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 10.0),
      Text(label, style: regularInputTextStyle,),
      const SizedBox(height: 10.0),
      TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        keyboardType: keyboardType,
        style: style,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        validator: (value){
          if (validatorID == 0) {
            return isPhone(value!);
          } else if (validatorID == 1) {
            return isEmail(value!);
          }
          return null;
        },
      ),
    ],
  );
}
String? isPhone(String value) {
  if (value.length < 11) {
    return "Nomor Hp tidak valid";
  }
  return null;
}

String? isEmail(String value) {
  if (value.contains("@")) {
    return null;
  }
  return "Invalid email address";
}
