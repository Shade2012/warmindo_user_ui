import 'package:flutter/material.dart';

import '../shimmer/shimmer.dart';
import 'myPopup_controller.dart';
import 'package:get/get.dart';
class DetailPopupShimmer extends StatelessWidget {
  final popUpController = Get.put(MyCustomPopUpController());
   DetailPopupShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Skeleton(width: 120,height: 20,),
        const SizedBox(height: 10),
        const Divider(color: Colors.grey,),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Skeleton(width: screenWidth * 0.6,height: 20,),
            Skeleton(width: screenWidth * 0.2,height: 20,),
          ],
        ),
        const SizedBox(height: 10),
        Skeleton(width: screenWidth * 0.4,height: 20,),
        const SizedBox(height: 10),
        Skeleton(width: screenWidth * 0.2,height: 20,),
        const SizedBox(height: 20),
        const Skeleton(width: double.infinity,height: 80,radius: 10,),
      ],
    );
  }
}
