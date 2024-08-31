import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/guest_navigator_page/controller/guest_navigator_controller.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';

import '../pages/navigator_page/controller/navigator_controller.dart';
import '../utils/themes/icon_themes.dart';
import '../utils/themes/textstyle_themes.dart';
Widget MinumanWidget(bool isGuest){
  final NavigatorController controller = Get.find<NavigatorController>();
  final GuestNavigatorController guestController = Get.find<GuestNavigatorController>();
  return GestureDetector(
    onTap:() {
      if(isGuest == true){
        guestController.goToGuestMenuPage(argument: 1);
      }else{
        controller.goToMenuPage(argument: 1);
      }
    } ,
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: ColorResources.tomatoRed,
              borderRadius: BorderRadius.circular(50.0)
          ),
          padding: const EdgeInsets.only(left: 12,right: 8,top: 10,bottom: 10),
          margin: const EdgeInsets.only(bottom: 5),
          width: 60,
          height: 60,
          child: Center(child: SvgPicture.asset(IconThemes.iconcoffe,color: Colors.white,)),
        ),
        Text("Minuman",style: boldTextStyle,)
      ],
    ),
  );
}
