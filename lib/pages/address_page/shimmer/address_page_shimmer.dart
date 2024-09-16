import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';

class AddressPageShimmer extends StatelessWidget {
  const AddressPageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.83,
      margin: const EdgeInsets.all(20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Column(
            children: [
              Skeleton(
                width: double.infinity,
                height: 160,
                radius: 10,
              ),
              SizedBox(height: 30,),
              Skeleton(
                width: double.infinity,
                height: 160,
                radius: 10,
              ),
            ],
          ),
          Skeleton(
            width: double.infinity,
            height: 80,
            radius: 10,
          ),
        ],
      ),
    );
  }
}
