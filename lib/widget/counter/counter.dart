
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';


import '../../utils/themes/textstyle_themes.dart';
import 'counter_controller.dart';

class CounterWidget extends StatelessWidget {
  final CounterController controller = Get.put(CounterController());


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          FloatingActionButton(
            onPressed: () {
              controller.subtract();

            },
            backgroundColor: ColorResources.primaryColor,
            mini: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Obx(() => Text(
            '${controller.quantity}',
            style: boldTextStyle,
          ),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              controller.add();

            },
            backgroundColor:  ColorResources.primaryColor,
            mini: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),

        ],
      ),
    );
  }
}
