import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';

class MenuShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(10),
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 1000,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3, // Change this to 5 for 5 items
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skeleton(height: 24, width: 50, radius: 5,),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Skeleton(height: 220, radius: 10)),
                        SizedBox(width: 20),
                        Expanded(child: Skeleton(height: 220, radius: 10))
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 50),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
