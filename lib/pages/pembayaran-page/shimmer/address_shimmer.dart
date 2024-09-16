import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';

class AddressShimmer extends StatelessWidget {
  AddressShimmer({super.key,});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: screenWidth,
      color: ColorResources.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Skeleton(height: 200,width: double.infinity,radius: 8),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
