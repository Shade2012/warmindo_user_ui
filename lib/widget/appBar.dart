import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppbarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle style;

  const AppbarCustom({required this.title, required this.style});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      title: Text(title,style: style,),
      centerTitle: true,
    );
  }
}
