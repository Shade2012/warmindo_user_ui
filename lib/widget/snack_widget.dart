import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/themes/icon_themes.dart';
import '../utils/themes/textstyle_themes.dart';
Widget SnackWidget(){
  return Container(
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.green,

              borderRadius: BorderRadius.circular(50.0)
          ),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 5),
          width: 60,
          height: 60,
          child: SvgPicture.asset(IconThemes.icon_french_fries,color: Colors.white,),
        ),
        Text("Snacks",style: boldTextStyle,)
      ],
    ),
  );
}
