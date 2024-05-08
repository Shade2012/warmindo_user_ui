import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';

import '../routes/AppPages.dart';
import '../utils/themes/icon_themes.dart';
import '../utils/themes/textstyle_themes.dart';
Widget MinumanWidget(){
  return GestureDetector(
    onTap:()=> Get.toNamed(Routes.MENU_PAGE,arguments: 1),
    child: Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: ColorResources.tomatoRed,
                borderRadius: BorderRadius.circular(50.0)
            ),
            padding: EdgeInsets.only(left: 12,right: 8,top: 10,bottom: 10),
            margin: EdgeInsets.only(bottom: 5),
            width: 60,
            height: 60,
            child: Center(child: SvgPicture.asset(IconThemes.iconcoffe,color: Colors.white,)),
          ),
          Text("Minuman",style: boldTextStyle,)
        ],
      ),
    ),
  );
}
