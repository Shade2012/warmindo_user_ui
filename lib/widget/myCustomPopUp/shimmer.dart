import 'package:flutter/material.dart';

import '../shimmer/shimmer.dart';
class MyPopupShimmer extends StatelessWidget {
  const MyPopupShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeleton(width: double.infinity,height: 300,radius: 5,),
          SizedBox(height: 10,),
          Skeleton(width: 130,),
          SizedBox(height: 10,),
          Skeleton(width: 40,),
          SizedBox(height: 10,),
          Skeleton(width: 40,),
          SizedBox(height: 10,),
          Skeleton(width: 120,),
          SizedBox(height: 10,),
          Skeleton(width: double.infinity,height: 70,),
          SizedBox(height: 10,),
          Skeleton(height: 150,radius: 10,),
        ],
      ),
    );
  }
}
