import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppbarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle style;

  const AppbarCustom({required this.title, required this.style});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      title: Text(title,style: style,),
      centerTitle: true,
      leading:
      InkWell(
          child: Ink(
            child: const Icon(Icons.arrow_back_ios_new)),
          onTap: (){
            Get.back();
    },
          )
    );
  }
}
