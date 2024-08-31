import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

Widget myText(
    IconData icon,
    TextInputType keyboardType,
    String label,
    String hint,
    TextEditingController controller,
    String? Function(String)? validator, // Validation function for email
    ) {
  return Container(
    margin: const EdgeInsets.only(top: 20, bottom: 20),
    child: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        hintText: hint,
        labelText: label,
        prefixIcon: Icon(icon),
        labelStyle: bold14,
        hintStyle: GoogleFonts.oxygen(
          textStyle: TextStyle(color: primaryTextColor, fontSize: 12),
        ),
        errorText: validator != null ? validator(controller.text) : null, // Show error text if validation fails
      ),
    ),
  );
}
