import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

class VerificationStatusPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorResources.verifyStatus, // Warna latar belakang
      content: Text(
        "Status verifikasi hanya dapat diberikan oleh admin",
        style: verifyStatusTextStyle, // Warna teks
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white), // Warna teks tombol
          ),
        ),
      ],
    );
  }
}
