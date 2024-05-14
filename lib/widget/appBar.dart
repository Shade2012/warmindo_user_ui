import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppbarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppbarCustom({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Icon(Icons.keyboard_arrow_left_sharp),
        ),
      ),
      title: Text(title),
      centerTitle: true,
    );
  }
}
