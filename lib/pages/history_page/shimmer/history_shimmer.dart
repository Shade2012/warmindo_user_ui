import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';

class HistoryShimmer extends StatelessWidget {
  const HistoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.73,
      margin: const EdgeInsets.all(20),
      // Skeleton(
      //   width: double.infinity,
      //   height: 160,
      //   radius: 10,
      // ),
      child: ListView.separated(
        itemCount: 5,
        itemBuilder: (context, index) {
          return const Skeleton( width: double.infinity,
                height: 100,
                radius: 10,);

      }, separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 20,);
      },),
    );
  }
}
