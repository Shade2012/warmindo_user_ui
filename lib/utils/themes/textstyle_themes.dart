import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//figma font size
figmaFontsize(double fontSize) {
  return fontSize * 0.95;
}

//Colors
Color primaryTextColor = Color(0xFF000000);
Color secondaryTextColor = Color(0xFFffffff);
Color greyTextColor = Color(0xFF696969);
Color greenTextColor = Color(0xFF007F6D);


TextStyle onboardingHeaderTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(20)));

TextStyle onboardingSubHeaderTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: greyTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(12)));

TextStyle onboardingButtonTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: greenTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(12)));