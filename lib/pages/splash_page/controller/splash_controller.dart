import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final token4 = prefs.getString('token4');
    await Future.delayed(const Duration(seconds: 1));
    _animationController.sink.add(0.3); // Green Circle
    _circleSizeController.sink.add(0.3); // Small size
    await Future.delayed(const Duration(seconds: 1));
    _animationController.sink.add(0.7); // Logo Circle
    _circleSizeController.sink.add(0.7); // Medium size
    await Future.delayed(const Duration(seconds: 1));
    _animationController.sink.add(0.6); // Orange Circle
    _circleSizeController.sink.add(0.6); // Medium size
    await Future.delayed(const Duration(seconds: 1));
    _animationController.sink.add(1);   // Red Circle
    _circleSizeController.sink.add(1);   // Large size
    await Future.delayed(const Duration(milliseconds: 400));
    if(token == null || token4 != null){
      Get.offNamed(Routes.ONBOARD_PAGE);
    } else{
      Get.offNamed(Routes.BOTTOM_NAVBAR);
    }
  }

  @override
  void onClose() {
    _animationController.close();
    _circleSizeController.close();
    super.onClose();
  }
}

