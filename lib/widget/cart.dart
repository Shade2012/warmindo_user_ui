import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/themes/icon_themes.dart';

Widget Cart (){
  return Container(
    width: 35,
    height: 35,
    decoration: BoxDecoration(
      color: Color.fromARGB(177, 217, 217, 217),
      borderRadius: BorderRadius.circular(50),
    ),
    child: Icon(Icons.shopping_cart,color: Colors.white,size: 24,),

  );
}
