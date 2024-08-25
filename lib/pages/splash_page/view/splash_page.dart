import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/splash_page/controller/splash_controller.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder<double>(
        stream: controller.animationStream,
        builder: (context, snapshot) {
          return StreamBuilder<double>(
            stream: controller.circleSizeStream,
            builder: (context, sizeSnapshot) {
              final double circleSize = sizeSnapshot.data ?? 1.0;
              final double animationValue = snapshot.data ?? 0.0;

              return Container(
                color: animationValue == 1 ? ColorResources.splashGradientEnd : Colors.transparent,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    height: MediaQuery.of(context).size.height * circleSize,
                    width: MediaQuery.of(context).size.width * circleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: animationValue == 0.3
                          ? ColorResources.splashGradientStart // Hijau
                          : animationValue == 0.6 // Oranye
                              ? ColorResources.splashGradientMid // Oranye
                              : Colors.transparent, // Transparan untuk logo
                    ),
                    child: animationValue == 0.7 // Tampilkan logo ketika mencapai 0.7
                        ? Image.asset(
                            Images.logo,
                            height: MediaQuery.of(context).size.height * circleSize,
                            width: MediaQuery.of(context).size.width * circleSize,
                          )
                        : null,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
