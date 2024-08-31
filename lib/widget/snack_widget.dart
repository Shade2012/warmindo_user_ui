import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../pages/guest_navigator_page/controller/guest_navigator_controller.dart';
import '../pages/navigator_page/controller/navigator_controller.dart';
import '../utils/themes/icon_themes.dart';
import '../utils/themes/textstyle_themes.dart';
Widget SnackWidget(bool isGuest){
  final NavigatorController controller = Get.find<NavigatorController>();
  final GuestNavigatorController guestController = Get.find<GuestNavigatorController>();
  return GestureDetector(
    onTap:(){
      if(isGuest == true){
        guestController.goToGuestMenuPage(argument: 3);
      }else{
        controller.goToMenuPage(argument: 3);
      }
      },
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.green,

              borderRadius: BorderRadius.circular(50.0)
          ),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 5),
          width: 60,
          height: 60,
          child: SvgPicture.asset(IconThemes.icon_french_fries,color: Colors.white,),
        ),
        Text("Snacks",style: boldTextStyle,)
      ],
    ),
  );
}
