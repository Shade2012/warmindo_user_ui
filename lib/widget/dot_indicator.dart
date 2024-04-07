import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';

class DotIndicator extends StatelessWidget {
  final int pageNumber;

  DotIndicator({required this.pageNumber});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i <= 2; i++)
          Container(
            margin: EdgeInsets.all(5),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: pageNumber == i ? ColorResources.tomatoRed : ColorResources.lightBrown,
            ),
          ),
      ],
    );
  }
}
