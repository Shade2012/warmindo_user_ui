import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';

class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Skeleton(width:105,),
        const SizedBox(height: 10,),
        Container(margin: const EdgeInsets.only(bottom: 40), child: const Skeleton(width: 50,)),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Skeleton(
              width: 70,height: 70,radius: 50,
            ),
            Skeleton(width: 70,height: 70,radius: 50,),
            Skeleton(width: 70,height: 70,radius: 50,),
          ],
        ),
        const SizedBox(height: 20,),
        const Skeleton(
          width: double.infinity,
          height: 70,radius: 10,
        ),
        const SizedBox(height: 20,),
        const Skeleton(
          width: double.infinity,
          height: 160,
        ),
        const SizedBox(height: 10,),
        const Skeleton(width: 220,),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Skeleton(width: screenWidth * 0.43,height: 210,radius: 10,),
          Skeleton(width: screenWidth * 0.43,height: 210,radius: 10,),
        ],),
        const SizedBox(height: 10,),
        const Skeleton(width: 100,),
        const SizedBox(height: 10,),
        Skeleton(width: screenWidth,height: 110,radius: 10,),
      ],
    );
  }
}
