import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';

class VoucherShimmer extends StatelessWidget {
  const VoucherShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          height: screenHeight * 0.8,
          child: Expanded(
            child: ListView.separated(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Skeleton( width: double.infinity,height: 200,radius: 10,);
              }, separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 20,);
            },
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20),
            child: Skeleton(width: double.infinity,height: 60,radius: 10,))
      ],
    );
  }
}
