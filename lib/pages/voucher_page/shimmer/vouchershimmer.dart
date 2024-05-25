import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';

class VoucherShimmer extends StatelessWidget {
  const VoucherShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 2,
        itemBuilder: (context, index) {
          return Skeleton( width: double.infinity,height: 200,radius: 10,);
        }, separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 20,);
    },
    );
  }
}
