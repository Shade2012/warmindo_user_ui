import 'dart:async';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';

class SplashController extends GetxController {
  final _animationController = StreamController<double>.broadcast();
  final _circleSizeController = StreamController<double>.broadcast();

  Stream<double> get animationStream => _animationController.stream;
  Stream<double> get circleSizeStream => _circleSizeController.stream;

  @override
  void onInit() {
    super.onInit();
    animate();
  }

  void animate() async {
    await Future.delayed(Duration(seconds: 1));
    _animationController.sink.add(0.3); // Green Circle
    _circleSizeController.sink.add(0.3); // Small size
    await Future.delayed(Duration(seconds: 1));
    _animationController.sink.add(0.7); // Logo Circle
    _circleSizeController.sink.add(0.7); // Medium size
    await Future.delayed(Duration(seconds: 1));
    _animationController.sink.add(0.6); // Orange Circle
    _circleSizeController.sink.add(0.6); // Medium size
    await Future.delayed(Duration(seconds: 1));
    _animationController.sink.add(1);   // Red Circle
    _circleSizeController.sink.add(1);   // Large size
    await Future.delayed(Duration(milliseconds: 400)); //buat hide
    Get.offNamed(Routes.ONBOARD_PAGE); 
  }

  @override
  void onClose() {
    _animationController.close();
    _circleSizeController.close();
    super.onClose();
  }
}
