import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';

class HistoryShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.73,
      margin: EdgeInsets.all(20),
      // Skeleton(
      //   width: double.infinity,
      //   height: 160,
      //   radius: 10,
      // ),
      child: ListView.separated(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Skeleton( width: double.infinity,
                height: 100,
                radius: 10,);

      }, separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 20,);
      },),
    );
  }
}
