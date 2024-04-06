
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';


Widget myText(
    IconData icon,
    String label,
    String hint,
    TextEditingController controller,
    ) {
  return Container(
    margin: EdgeInsets.only(top: 20,bottom: 20),

    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black)
        ),
        hintText: hint,
        labelText: label,
        prefixIcon: Icon(icon),
        labelStyle:(boldTextStyle),
        hintStyle: GoogleFonts.oxygen(
          textStyle: TextStyle(color: primaryTextColor, fontSize: 12),
        ),
      ),
    ),
  );
}

