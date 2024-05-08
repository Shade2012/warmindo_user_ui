import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../pages/menu_page/view/menu_page.dart';
import '../routes/AppPages.dart';
import '../utils/themes/icon_themes.dart';
import '../utils/themes/textstyle_themes.dart';
Widget MakananWidget(){
  return GestureDetector(
    onTap: (){
      Get.toNamed(Routes.MENU_PAGE, arguments: 2,);
    },
    child: Container(

      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,

              borderRadius: BorderRadius.circular(50.0)
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 5),
            width: 60,
            height: 60,
            child: SvgPicture.asset(IconThemes.iconburger,color: Colors.white,),
          ),
          Text("Makanan",style: boldTextStyle,)
        ],
      ),
    ),
  );
}
