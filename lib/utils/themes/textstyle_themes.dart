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
Color bluelinkTextColor = Color(0xFF289BF6);

TextStyle boldgreyText = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: greyTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(15)));

TextStyle regulargreyText = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: greyTextColor,
        fontWeight: FontWeight.normal,
        fontSize: figmaFontsize(15)));

TextStyle onboardingHeaderTextStyle = GoogleFonts.oxygen(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(20));

TextStyle headerBold = GoogleFonts.oxygen(
    color: primaryTextColor,
    fontWeight: FontWeight.bold,
    fontSize: figmaFontsize(25));

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


TextStyle headerRegularStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.normal,
        fontSize: figmaFontsize(25)));

TextStyle subheaderRegularStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.normal,
        fontSize: figmaFontsize(20)));

TextStyle boldTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(15)));

TextStyle otpcode = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(25)));

TextStyle LoginboldTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: ColorResources.primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(15)));


TextStyle regularTextStyle = GoogleFonts.oxygen(
  textStyle:TextStyle(
      color: primaryTextColor,
      fontWeight: FontWeight.normal,
      fontSize: figmaFontsize(17)));

TextStyle boldTextStyle2 = GoogleFonts.oxygen(
    textStyle:TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(20)));

TextStyle whiteboldTextStyle15 = GoogleFonts.oxygen(
    textStyle:TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(15)));

TextStyle whiteregulerTextStyle15 = GoogleFonts.oxygen(
    textStyle:TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.normal,
        fontSize: figmaFontsize(15)));


TextStyle whiteboldTextStyle = GoogleFonts.oxygen(
    textStyle:TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(17)));

TextStyle headerboldverifyTextStyle = GoogleFonts.oxygen(
    textStyle:TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(38)));

TextStyle subheaderverifyTextStyle = GoogleFonts.oxygen(
    textStyle:TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.normal,
        fontSize: figmaFontsize(14)));

TextStyle boldphoneNumberTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(14)));

TextStyle boldcodeTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(30)));

TextStyle bluelinkTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: bluelinkTextColor,
        fontWeight: FontWeight.normal,
        fontSize: figmaFontsize(16)));


TextStyle descriptionTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.normal,
        fontSize: figmaFontsize(12)));

TextStyle vouchertextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(13)));


TextStyle priceTextStyle =  GoogleFonts.oxygen(textStyle: TextStyle(
    color: greenTextColor,
    fontWeight: FontWeight.normal,
    fontSize: figmaFontsize(14)));

TextStyle ratingTextStyle =  GoogleFonts.oxygen(textStyle: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: figmaFontsize(14)));

TextStyle descriptionratingTextStyle =  GoogleFonts.oxygen(textStyle: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: figmaFontsize(16)));

TextStyle nameProfileTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(24)));

TextStyle usernameProfileTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.normal,
        fontSize: figmaFontsize(17)));

TextStyle editProfileTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(12)));

TextStyle appBarTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(20)));

TextStyle boldPolicyTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(14)));

TextStyle normalPolicyTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.normal,
        fontSize: figmaFontsize(14)));

TextStyle blackvoucherTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(14)));

TextStyle whitevoucherTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(14)));

TextStyle verifyStatusTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(14)));

TextStyle contentDialogButtonTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(12)));

TextStyle titleDialogButtonTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(14)));


TextStyle dialogButtonTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(12)));

TextStyle hintSearchBarTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w300,
        fontSize: figmaFontsize(15)));

TextStyle categoryMenuBarTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.w300,
        fontSize: figmaFontsize(17)));

TextStyle categoryMenuTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(14)));


TextStyle menuNameTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w400,
        fontSize: figmaFontsize(16)));

TextStyle menuDescTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w400,
        fontSize: figmaFontsize(12)));

TextStyle menuPriceTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w400,
        fontSize: figmaFontsize(16)));

TextStyle regulerinfotext = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w400,
        fontSize: figmaFontsize(14)));




