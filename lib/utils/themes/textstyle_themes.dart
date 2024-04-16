import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';

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
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(20));

TextStyle onboardingSubHeaderTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: greyTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(12)));

TextStyle onboardingskip = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: greyTextColor,
        fontWeight: FontWeight.normal,
        fontSize: figmaFontsize(14)));

TextStyle onboardingButtonTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: greenTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(12)));

TextStyle regularInputTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.normal,
        fontSize: figmaFontsize(15)));

TextStyle boldTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(15)));

TextStyle LoginboldTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: ColorResources.primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(15)));


TextStyle regularTextStyle = GoogleFonts.oxygen(
  textStyle:TextStyle(
      color: primaryTextColor,
      fontWeight: FontWeight.normal,
      fontSize: figmaFontsize(17)
  )
);

TextStyle whiteboldTextStyle = GoogleFonts.oxygen(
    textStyle:TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(17)
    )
);
