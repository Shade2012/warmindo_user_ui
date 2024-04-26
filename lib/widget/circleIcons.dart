import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';

class CircleIcon extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final double iconSize;
  final Color backgroundColor;
  final double size;

  const CircleIcon({
    Key? key,
    required this.iconData,
    this.iconColor = ColorResources.primaryTextColor,
    this.iconSize = 20.0,
    this.backgroundColor = ColorResources.vouchercircleIcon, // Default background color
    this.size = 45.0, // size of the circle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: Center(
        child: Icon(
          iconData,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
