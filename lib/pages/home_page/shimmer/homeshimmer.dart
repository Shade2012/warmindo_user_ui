import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';

class HomeSkeleton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Skeleton(width:105,),
         SizedBox(height: 10,),
         Container(margin: EdgeInsets.only(bottom: 40), child: Skeleton(width: 50,)),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
             Skeleton(
               width: 70,height: 70,radius: 50,
             ),
             Skeleton(width: 70,height: 70,radius: 50,),
             Skeleton(width: 70,height: 70,radius: 50,),
           ],
         ),
         SizedBox(height: 20,),
         Skeleton(
           width: double.infinity,
           height: 160,
         ),
         SizedBox(height: 10,),
         Skeleton(width: 220,),
         SizedBox(height: 20,),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
           Skeleton(width: screenWidth * 0.43,height: 210,radius: 10,),
           Skeleton(width: screenWidth * 0.43,height: 210,radius: 10,),
         ],),
         SizedBox(height: 10,),
         Skeleton(width: 100,),
         SizedBox(height: 10,),
         Skeleton(width: screenWidth,height: 110,radius: 10,),
       ],
     ),
    );
  }
}
