import 'package:flutter/material.dart';

import '../utils/themes/image_themes.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyimageRadius = true,
    this.border, this.fit = BoxFit.contain,
    this.padding,
    this.onPressed,
  });

  final double? width,height;
  final String imageUrl;
  final bool applyimageRadius;
  final BoxBorder? border;
  final Color backgroundColor = Colors.white;
  final BoxFit fit;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,color: backgroundColor,
            borderRadius: BorderRadius.circular(10.0)
        ),
        child: ClipRRect(
          borderRadius: applyimageRadius ? BorderRadius.circular(10.0) : BorderRadius.zero,
          child: Image(image: AssetImage(imageUrl),fit: fit,),
        ),
      ),
    );
  }
}
