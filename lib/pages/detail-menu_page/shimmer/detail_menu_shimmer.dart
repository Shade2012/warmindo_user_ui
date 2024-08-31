import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';

class MenuDetailSkeleton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeleton(height: screenHeight * 0.3,width: double.infinity,radius: 10,),
          const SizedBox(height: 10),
          const Skeleton(height: 20,width: 170,radius: 5,),
          const SizedBox(height: 10),
          const Skeleton(height: 20,width: 60,radius: 5,),
          const SizedBox(height: 10),
          const Skeleton(height: 35,width: 50,radius: 5,),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          const Skeleton(height: 20,width: 70,radius: 5,),
          const SizedBox(height: 10),
          const Skeleton(height: 180,width: double.infinity,radius: 5,),
        ],
      )
    );
  }
}
